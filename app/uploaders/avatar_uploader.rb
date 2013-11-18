class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include CarrierWave::Processing::RMagick

  storage :fog
  process colorspace: :cmyk
  process convert: :png
  process quality: 100

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path('fallback/default.png')
  end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png bmp)
  end

  def filename
    return super.chomp(File.extname(super)) + '.png' unless super.nil?
    default_url.chomp(File.extname(default_url)) + '.png'
  end
end
