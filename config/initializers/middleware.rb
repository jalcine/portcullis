require 'rack/contrib/time_zone'

Portcullis::Application.configure do
  config.middleware.insert_before Rack::ETag, Rack::TimeZone

  if Rails.env.development?
    require 'rack-livereload'
    #require 'rack/contrib/profiler'
    #config.middleware.use Rack::Profiler, {printer: 'RubyProf::GraphPrinter', times: 2}

    Portcullis::Application.configure do
      # Local machine.
      config.middleware.insert_before Rack::Lock, Rack::LiveReload, {
        min_delay: 5e2,
        max_delay: 1e4,
        source: :livereload
      }

      # Over Intranet/Internet
      config.middleware.insert_before Rack::Lock, Rack::LiveReload, {
        min_delay: 5e2,
        max_delay: 1e4,
        host: Settings.local.host,
        source: :livereload,
        force_swf: true
      }
    end
  end
end
