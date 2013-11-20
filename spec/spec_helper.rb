ENV['RAILS_ENV'] ||= 'test'
ENV['NEWRELIC_ENABLE'] = 'false'

def prefork_some_jazz
  require File.expand_path('../../config/environment', __FILE__)
  Dir[Rails.root.join('spec/support/prefork/**/*.rb')].each { |f| require f }
  Dir[Rails.root.join('spec/support/modules/**/*.rb')].each { |f| require f }
  RSpec.configure do | config |
    config.include ViewHelpers, type: :view
    config.include ControllerHelpers, type: :controller
  end
end

def pre_run_some_jazz
  Dir[Rails.root.join('spec/support/run/**/*.rb')].each { |f| require f }
end

require 'rubygems'

if ENV['DRB']
  require 'spork'
  Spork.prefork do
    prefork_some_jazz
  end

  Spork.each_run do
    pre_run_some_jazz
  end
else
  puts "[I #{DateTime.now.to_s}] Coverage will be run."
  require 'simplecov'
  SimpleCov.start 'rails'
  prefork_some_jazz
  pre_run_some_jazz
  puts "[I #{DateTime.now.to_s}] Isolated test completed."
end
