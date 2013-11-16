module ApplicationHelper
  def page_title(title = nil)
    if title.nil?
      return content_for(:page_title)
    else
      content_for(:page_title, "#{title} - Vettio")
    end
  end

  def navigation_state(state = nil)
    if state.nil?
      return content_for(:navigation_state)
    else
      content_for(:navigation_state, state)
    end
  end
end
