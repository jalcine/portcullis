class EventBannerUploader < ImageUploader
   version :boxed do
     process resize_to_fill: [256, 192]
   end

   version :masthead do
     process resize_to_fill: [1024, 768]
   end

  def default_url
    ActionController::Base.helpers.asset_path('placebo.jpg')
  end
end
