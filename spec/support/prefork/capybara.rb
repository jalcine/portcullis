require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara/rails'
require 'capybara-screenshot'

RSpec.configure do | config |
  test_log = File.new "#{Rails.root}/log/test.log", 'a'

  Capybara.register_driver :vettio_webdriver do | app |
    Capybara::Poltergeist::Driver.new app, {
      debug: true,
      server: true,
      js_errors: false,
      logger: test_log,
      phantomjs_logger: test_log,
      window_size: [1366, 768]
    }
  end

  Capybara.default_driver     = :vettio_webdriver
  Capybara.javascript_driver  = :vettio_webdriver
  Capybara.default_wait_time  = 5

  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers, type: :views
  config.include Capybara::RSpecMatchers, type: :helpers
  config.include Capybara::RSpecMatchers, type: :feature

  Rails.application.reload_routes! 
  config.before(:each) { Rails.application.reload_routes! }
end
