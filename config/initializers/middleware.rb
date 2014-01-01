require 'rack/contrib/time_zone'

Portcullis::Application.configure do
  config.middleware.use Rack::Attack
  config.middleware.use Rack::Referrals
  config.middleware.use Rack::TimeZone

  if Rails.env.development?
    require 'rack-livereload'

    # Local machine.
    config.middleware.insert_before Rack::Lock, Rack::LiveReload, {
      min_delay: 5e2,
      max_delay: 1e4,
      source: :livereload
    }

    # Remote machine.
    config.middleware.insert_before Rack::Lock, Rack::LiveReload, {
      host: Settings.local.host,
      min_delay: 5e2,
      max_delay: 1e4,
      source: :livereload
    }
  end
end
