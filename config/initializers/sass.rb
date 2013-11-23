Portcullis::Application.configure do
  config.sass.relative_assets = false
  config.sass.disable_warnings = false

  if !Rails.env.production? then
    config.sass.style = :nested
    config.sass.quiet = false
    config.sass.cache = true
    config.sass.line_comments = true
    config.sass_line_numbers = true
    config.sass.full_exception = true
    config.sass.debug_info = true
  end
end
