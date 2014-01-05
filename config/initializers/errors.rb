Airbrake.configure do |config|
  config.api_key = Settings.errbit.api_key
  config.host    = Settings.errbit.host
  config.port    = Settings.errbit.port
  config.secure  = config.port == 443
end
