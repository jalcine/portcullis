module ApplicationHelper
  def is_in_beta?
    Settings.toggles.in_beta == true
  end

  ['navigation', 'footer', 'header'].each do | section |
    module_eval <<-METHODS, __FILE__, __LINE__ +1
      def #{section}_visible?
        @#{section}_visible = true if @#{section}_visible.nil?
        Rails.logger.info "#{section} visible? (\#{@#{section}_visible})"
        @#{section}_visible
      end

      def disable_#{section}
        @#{section}_visible = false
      end

      def enable_#{section}
        @#{section}_visible = true 
      end
    METHODS
  end

  def show_error_page(code = :internal_server_error, message = 'Awh shucks')
    # TODO: Change error page depending on status code.
    flash[:error] = message
    render status: code, template: 'errors/500' 
  end

  def page_title(subtitle = nil)
    @view_flow.content.delete :title
    content_for :title do
      "#{subtitle} - Vettio"
    end
  end

  def page_classes(params = nil)
    if params.is_a? String
      content_for(:page_classes) do
        params
      end
    else if params.is_a? Hash
      santizied_params = "#{params[:controller]} #{params[:action]}".gsub('/', '_').gsub('-','_').downcase
      return "#{santizied_params} #{content_for(:page_classes)}"
    end
  end
end
end
