module ApplicationHelper
  def is_in_beta?
    Settings.toggles.in_beta == true
  end

  def browser
    Browser.new accept_language: request.headers['Accept-Language'],
      ua: request.headers['User-Agent']
  end

  def page_title(subtitle = nil)
    if subtitle.nil?
      a_title = content_for(:title)
      a_title = 'Vettio' if a_title.nil?
      return a_title
    else
      if subtitle.blank? or !subtitle.is_a? String
        subtitle = 'Vettio'
      else
        subtitle = "#{subtitle} - Vettio"
      end

      content_for :title, flush: true do
        subtitle
      end
    end
  end

  def page_classes(params = nil)
    return content_for(:page_classes) if params.nil?


    if params.is_a? String then
      content_for(:page_classes) do
        params
      end
    else if params.is_a? Hash then
      santizied_params = "#{params[:controller]} #{params[:action]}".gsub('/', '_').gsub('-','_').downcase
      return "#{santizied_params} #{content_for(:page_classes)}"
    end
  end
end
end
