unless Rails.env.production?
  require 'rack/livereload'

  Portcullis::Application.configure do
    config.middleware.use Rack::LiveReload
  end
end
