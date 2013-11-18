module ViewHelpers
  def add_view_path(path)
    view.lookup_context.view_paths.push path
  end

  def devise_mapping
    Devise.mappings[:user] || request.env['devise.mapping']
  end

  def handle_devise
    allow(view).to receive(:devise_mapping).and_return(devise_mapping)
    allow(view).to receive(:is_in_registrations?).and_return(:false)
    allow(view).to receive(:is_in_sessions?).and_return(:false)
    allow(view).to receive(:is_in_passwords?).and_return(:false)
  end
end
