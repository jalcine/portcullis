require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot'

RSpec.configure do | config |
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers, type: :views
  config.include Capybara::RSpecMatchers, type: :helpers

  test_log = File.new "#{Rails.root}/log/test.log", 'a'

  Capybara.register_driver :poltergeist do | app |
    Capybara::Poltergeist::Driver.new app, {
      debug: false,
      js_errors: true,
      logger: test_log,
      phantomjs_logger: test_log
    }
  end

  Capybara.default_selector   = :css
  Capybara.default_driver     = :poltergeist
  Capybara.javascript_driver  = :poltergeist
  Capybara.default_wait_time  = 30
  Capybara.visible_text_only  = false
  Capybara.app_host = 'http://lvh.me' # Redirect to http://127.0.0.1/
end
