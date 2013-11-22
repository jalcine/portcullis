require 'rack/contrib/time_zone'
#require 'rack/contrib/profiler'

Portcullis::Application.configure do
  config.middleware.insert_before Rack::ETag, Rack::TimeZone

  if Rails.env.development?
    #config.middleware.use Rack::Profiler, {printer: 'RubyProf::GraphPrinter', times: 2}
  end
end
