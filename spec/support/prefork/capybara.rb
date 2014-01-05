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
      debug: false,
      server: true,
      js_errors: false,
      inspector: true,
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
  config.include Capybara::RSpecMatchers
end
