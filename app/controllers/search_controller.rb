class SearchController < ApplicationController
  def new
  end

  def present
    @events = Event.unscoped.all
  end
end
