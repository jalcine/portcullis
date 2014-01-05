require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara/rails'
require 'capybara-screenshot'
require 'capybara-screenshot/rspec'

RSpec.configure do | config |
  phantomjs_logger = File.new "#{Rails.root}/log/test.log", 'a'
  test_log = File.new "#{Rails.root}/log/phantomjs.log", 'a'

  # TODO: Register three drivers, each for different device sizes.
  Capybara.register_driver :poltergeist do | app |
    Capybara::Poltergeist::Driver.new app, {
      js_errors: false,
      server: false,
      logger: test_log,
      phantomjs_logger: phantomjs_logger
    }
  end

  Capybara.default_driver                  = :poltergeist
  Capybara.javascript_driver               = :poltergeist
  Capybara.ignore_hidden_elements          = false 
  Capybara.default_wait_time               = 10
  Capybara::Screenshot.autosave_on_failure = false

  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers, type: :views
  config.include Capybara::RSpecMatchers, type: :helpers
  config.include Capybara::RSpecMatchers, type: :feature
  config.include ApplicationHelper, type: :feature
end
