require 'rack/contrib/time_zone'
require 'better_errors/middleware'
#require 'rack/contrib/profiler'

Portcullis::Application.configure do
  config.middleware.insert_before Rack::ETag, Rack::TimeZone

  if Rails.env.development?
    config.middleware.insert_before Rack::Lock, BetterErrors::Middleware 
    #config.middleware.use Rack::Profiler, {printer: 'RubyProf::GraphPrinter', times: 2}
  end
end
