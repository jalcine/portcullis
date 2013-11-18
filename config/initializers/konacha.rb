Portcullis::Application.configure do
  require 'capybara/poltergeist'

  Konacha.configure do |config|
    config.spec_dir     = 'spec/javascripts'
    config.spec_matcher = /_spec\./
    config.stylesheets  = %w(application)
    config.driver       = :poltergeist
  end
end if Rails.env.development? 
