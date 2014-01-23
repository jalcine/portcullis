class Users::OmniauthController < Devise::OmniauthCallbacksController
  private
  def omniauth_auth
    request.env['omniauth.auth']
  end

  private
  def omniauth_params
    request.env['omniauth.params']
  end

  private
  def is_omniauth_auth_malformed?
    return true if omniauth_auth.empty? or omniauth_auth.nil?
    ['provider', 'uid', 'info', 'credentials'].each do | key |
      unless omniauth_auth.keys.include? key
        Rails.logger.info "Exception! #{key} key is missing" 
        return true
      end
    end
    false
  end

  private
  def create_user_with_oauth(provider)
    info = omniauth_auth['info']
    @user = User.find_by_email(info['email'])
    return :error_user_exists if @user.present?

    @user = User.new email: info['email']
    add_provider_to_user(provider)
    @provider.import_from_oauth omniauth_auth['info']
    return :error_profile_missing if @provider.nil?
    @user.grant :attendee

    begin
      @user.save!
      @provider.save!
    rescue ActiveRecord::RecordInvalid
      return :error_user_is_malformed
    end
    :user_created
  end

  private
  def find_user_from_oauth(provider)
    email = omniauth_auth['info']['email']
    @user = User.find_by_email(email)
    return :error_not_found if @user.nil?
    return :user_found
  end

  private
  def validate_parameters!
    redirect_to new_user_session_path, error: t('auth.failure') and return false if omniauth_params.nil?

    @user = nil
    @task = omniauth_params['task'].to_s if omniauth_params.keys.include? 'task'
    no_good = (@task.nil? || omniauth_params.empty?)

    redirect_to new_user_registration_path, error: t('auth.failure') and return false if no_good
    redirect_to new_user_registration_path, error: t('auth.failure') and return false if is_omniauth_auth_malformed?
    return true
  end

  private
  def add_provider_to_user(provider)
    return if @user.providers.where(name: provider.to_s).present?
    @provider = @user.providers.build name: provider.to_sym,
      token: omniauth_auth['credentials']['token'].to_s,
      uid: omniauth_auth['uid'].to_s,
      user: @user
  end

  private
  def do_the_deed(provider)
    return unless validate_parameters!

    case @task.to_s
    when 'new'
      case find_user_from_oauth(provider)
      when :error_not_found
        status = create_user_with_oauth(provider)
        case status
        when :error_user_is_malformed
          redirect_to new_user_registration_path, 
            status: :internal_server_error, error: t('auth.create_failure') and return
        when :error_profile_missing
          redirect_to new_user_registration_path, status: :not_found,
            error: t('auth.error_profile') and return
        when :user_created
          flash[:notice] = t('auth.create')
        end
      when :user_found
        @user = User.find_by_email(omniauth_auth['info']['email'])
        add_provider_to_user(provider)
        @provider.import_from_oauth(omniauth_auth['info']) if @user.profile.nil?
      end
    when 'find'
      case find_user_from_oauth(provider)
      when :error_not_found
        redirect_to new_user_session_path, status: :internal_server_error,
          error: t('auth.failure') and return
      when :user_found
        flash[:notice] = t('auth.welcome')
        @provider = @user.providers.where(name: provider)
        @provider.import_from_oauth(omniauth_auth['info']) if @user.profile.nil?
      end
    else
      redirect_to new_user_session_pathstatus: :not_found,
        error: t('auth.failure') and return
    end

    return complete_the_deed(@user)
  end

  private
  def complete_the_deed(user = @user)
    flash[:notice] = "Welcome #{@user.profile.first_name}!"
    sign_in_and_redirect @user and return true unless @user.nil?
    redirect_to new_user_session_path,  error: t('auth.failure') and return true if @user.nil
    false
  end

  Settings.authentication.providers.each do | provider, _ |
    class_eval <<-METHODS, __FILE__, __LINE__+1
    public
    def #{provider}
      do_the_deed('#{provider}')
    end
    METHODS
  end

  public
  def failure
    redirect_to new_user_session_path, status: 401, alert: t('auth.failure') and return
  end
end
