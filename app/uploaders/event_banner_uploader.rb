class EventBannerUploader < ImageUploader
   version :boxed do
     process resize_to_fill: [256, 256]
   end

   version :masthead do
   end

  def default_url
    ActionController::Base.helpers.asset_path('placeabo.jpg')
  end
end
