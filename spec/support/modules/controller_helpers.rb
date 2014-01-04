module ControllerHelpers
  def login_user(user = FactoryGirl.create(:user))
    stub_env_for_devise
    sign_in user
  end

  def logout_user
    sign_out current_user
  end

  def stub_env_for_devise(user_role = :user)
    request.env['devise.mapping'] = Devise.mappings[user_role]
  end

  def stub_env_for_omniauth_error(provider)
    OmniAuth.config.mock_auth[provider.downcase.to_sym] = :invalid_credentials
  end

  def stub_env_for_omniauth(provider)
    request.env['omniauth.auth'] = oauth_hash(provider)
  end

  def stub_env_for_omniauth_params(paramaters = {})
    request.env['omniauth.params'] = paramaters
  end
end
