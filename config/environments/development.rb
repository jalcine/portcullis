Portcullis::Application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.serve_static_assets  = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = true
  config.action_controller.allow_forgery_protection = true
  config.active_support.deprecation = :stderr
  config.log_level = :debug
end
