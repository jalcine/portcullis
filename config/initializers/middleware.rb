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
        no_swf: true,
        min_delay: 30,
        max_delay: 100
      }

      # Over Intranet/Internet
      config.middleware.insert_before Rack::Lock, Rack::LiveReload, {
        no_swf: true,
        min_delay: 30,
        max_delay: 100,
        host: Settings.local.host
      }
    end
  end
end
