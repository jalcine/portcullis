Portcullis::Application.configure do
  config.sass.relative_assets = true
  config.sass.disable_warnings = true 
  config.sass.sourcemap = true

  if !Rails.env.production? then
    config.sass.style = :expanded
    config.sass.cache = true
    config.sass.quiet = false
    config.sass.line_comments = true
    config.sass_line_numbers = true
    config.sass.full_exception = true
    config.sass.debug_info = true
  end
end
