require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot'

RSpec.configure do | config |
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers, type: :views
  config.include Capybara::RSpecMatchers, type: :helpers
  config.include Capybara::RSpecMatchers, type: :feature

  test_log = File.new "#{Rails.root}/log/test.log", 'a'

  Capybara.register_driver :poltergeist do | app |
    Capybara::Poltergeist::Driver.new app, {
      debug: true,
      server: false,
      js_errors: false,
      logger: test_log,
      phantomjs_logger: test_log,
      window_size: [1300, 1000]
    }
  end

  Capybara.default_selector   = :css
  #Capybara.default_driver     = :poltergeist
  Capybara.javascript_driver  = :poltergeist
  Capybara.visible_text_only  = true
  Capybara.app_host = 'http://lvh.me' # Redirect to http://127.0.0.1/
  Rails.application.routes.default_url_options[:host] = Capybara.app_host
end
