class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include CarrierWave::Processing::RMagick

  process colorspace: :cmyk
  process convert: :png
  process quality: 100

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path('hazy_circle.jpg')
  end

  def extension_white_list
    %w(jpg jpeg gif png bmp tiff)
  end
end
