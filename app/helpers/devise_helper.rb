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
    return '' if resource.errors.empty?
    messages = resource.errors.full_messages.map { | msg | content_tag :li, msg }.join
    sentence = I18n.t('errors.messages.not_saved', count: resource.errors.count, resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <p class='alert-box warning'>
      <b>#{sentence}</b>
      <ul>#{messages}</ul>
    </p>
HTML

    html.html_safe
  end
end
