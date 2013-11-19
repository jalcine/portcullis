require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot'

RSpec.configure do | config |
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers, type: :views
  config.include Capybara::RSpecMatchers, type: :helpers

  Capybara.register_driver :poltergeist do | app |
    Capybara::Poltergeist::Driver.new app, {
      debug: false,
      js_errors: false
    }
  end

  Capybara.default_selector   = :css
  Capybara.default_driver     = :poltergeist
  Capybara.javascript_driver  = :poltergeist
  Capybara.default_wait_time  = 2
  Capybara.visible_text_only  = false
  #Capybara.app_host = 'http://lvh.me/' # Redirect to http://127.0.0.1/

  Capybara.add_selector(:li) do
    xpath { |num| ".//li[#{num}]" }
  end

  Capybara.add_selector(:dd) do
    xpath { |num| ".//li[#{num}]" }
  end
end
