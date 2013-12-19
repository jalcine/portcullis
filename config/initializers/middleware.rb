require 'rack/contrib/time_zone'

Portcullis::Application.configure do
  config.middleware.insert_before Rack::ETag, Rack::TimeZone

  if Rails.env.development?
    require 'rack-livereload'
    #require 'rack/contrib/profiler'
    #config.middleware.use Rack::Profiler, {printer: 'RubyProf::GraphPrinter', times: 2}

    Portcullis::Application.configure do
      # Local machine.
      config.middleware.use Rack::LiveReload

      # Over Intranet/Internet
      config.middleware.use Rack::LiveReload, {
        host: Settings.local.host
      }
    end
  end
end
