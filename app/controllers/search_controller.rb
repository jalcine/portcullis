class SearchController < ApplicationController
  def new
  end

  def present
    query = params[:query]
    @results = Event.unscoped.all

    #@results = Event.tire.search load: true do 
      #query { string query }
    #end
  end
end
