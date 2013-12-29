class TinymceAssetsController < ApplicationController
  def create
    image = params[:image]
    Rails.logger.debug image
    render json: {
      image: {
        url: view_context.image_url(image)
      }
    }, content_type: 'text/html'
  end
end
