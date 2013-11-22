require 'rack/contrib/time_zone'
require 'rack/contrib/profiler'
require 'rack/contrib/print_out'

Rails.applicaiton.configure do
  config.middleware.insert_before Rack::ETag, Rack::TimeZone

  if Rails.env.development?
    config.middleware.use Rack::Profiler
    config.middleware.use Rack::Printout
  end
end
