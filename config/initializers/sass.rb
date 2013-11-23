Portcullis::Application.configure do
  require 'compass/rails'
  config.sass.relative_assets = true
  config.sass.disable_warnings = true

  if !Rails.env.production? then
    config.sass.style = :nested
    config.sass.quiet = true
    config.sass.cache = true
    config.sass.line_comments = true
    config.sass_line_numbers = true
    config.sass.full_exception = true
    config.sass.debug_info = true
  end
end
