if Rails.env.development?
  require 'rack-livereload'

  Portcullis::Application.configure do
    # Local machine.
    config.middleware.insert_before BetterErrors::Middleware, Rack::LiveReload, {
      no_swf: true,
      min_delay: 30,
      max_delay: 100
    }

    # Over Intranet/Internet
    config.middleware.insert_before BetterErrors::Middleware, Rack::LiveReload, {
      no_swf: true,
      min_delay: 30,
      max_delay: 100,
      host: Settings.local.host
    }
  end
end
