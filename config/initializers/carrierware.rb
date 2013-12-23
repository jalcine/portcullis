CarrierWave.configure do | config |
  if Rails.env.development?
    config.storage = :file
  else
    config.storage = :fog
  end
end
