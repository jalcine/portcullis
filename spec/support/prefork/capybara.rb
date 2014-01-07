require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara/rails'
require 'capybara-screenshot'
require 'capybara-screenshot/rspec'

RSpec.configure do | config |
  test_log         = File.new "#{Rails.root}/log/test.log", 'a'
  phantomjs_logger = File.new "#{Rails.root}/log/phantomjs.log", 'a'

  Capybara.register_driver :poltergeist do | app |
    Capybara::Poltergeist::Driver.new app, {
      js_errors: false,
      logger: test_log,
      phantomjs_logger: phantomjs_logger,
      timeout: 90
    }
  end

  Capybara.default_driver    = :poltergeist
  Capybara.current_driver    = :poltergeist
  Capybara.javascript_driver = :poltergeist

  config.include Capybara::DSL
  config.include ApplicationHelper, type: :feature
  config.include Capybara::RSpecMatchers, type: :views
  config.include Capybara::RSpecMatchers, type: :helpers
  config.include Capybara::RSpecMatchers, type: :feature
end
