Airbrake.configure do |config|
  config.api_key = Settings.errbit.key
  config.host    = Settings.errbit.hos
  config.port    = Settings.errbit.port
  config.secure  = config.port == 443
end if defined?(Airbrake) and defined?(Settings.errbit)
