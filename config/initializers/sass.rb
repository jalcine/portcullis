require 'sass-rails'

Portcullis::Application.configure do
  if !Rails.env.production? then
    config.sass.line_comments = true
    config.sass_line_numbers = true
    config.sass.cache = true
    config.sass.style = :nested
    config.sass.quiet = false
  end
end
