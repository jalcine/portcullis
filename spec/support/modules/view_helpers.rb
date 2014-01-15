module ViewHelpers
  def add_view_path(path)
    view.lookup_context.view_paths.push path
  end

  def devise_mapping
    Devise.mappings[:user] || request.env['devise.mapping']
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def set_current_user_to(user = create(:user))
    allow(view).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  def handle_devise
    allow(view).to receive(:devise_mapping).and_return(devise_mapping)
    allow(view).to receive(:is_in_registrations?).and_return(:false)
    allow(view).to receive(:is_in_sessions?).and_return(:false)
    allow(view).to receive(:is_in_passwords?).and_return(:false)
    allow(view).to receive(:user_signed_in?).and_return(:false)
  end
end
