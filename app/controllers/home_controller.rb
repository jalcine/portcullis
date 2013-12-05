class HomeController < ApplicationController
  def landing
    render 'home/index'
  end

  ['about', 'privacy_policy', 'terms_of_service'].each do | page |
    class_eval <<-METHODS, __FILE__, __LINE__ +1
      def #{page}
      end
    METHODS
  end

  def rescue_from_routing_error
    render status: :not_found, template: 'errors/500'
  end
end
