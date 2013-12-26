class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include CarrierWave::Processing::RMagick

  # All of the images used by the platform should be converted into pngs
  # and processed in the CMYK colorspace.
  process colorspace: :cmyk
  process convert: :png

  # TODO: Define a more proper location for these images.
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    # TODO: Define a sane default image.
    ActionController::Base.helpers.asset_path('empty.png')
  end


  def extension_white_list
    %w(jpg jpeg gif png bmp tiff)
  end
end
