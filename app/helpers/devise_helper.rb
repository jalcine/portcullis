module DeviseHelper
  def in_sessions?
    controller_name == 'sessions'
  end

  def in_registrations?
    controller_name == 'registrations'
  end

  def in_passwords?
    controller_name == 'passwords'
  end

  def devise_error_messages!
    return nil if resource.errors.empty?
    return resource.errors
  end
end
