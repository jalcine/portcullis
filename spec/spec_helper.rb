ENV['RAILS_ENV'] = 'test'
ENV['NEWRELIC_ENABLE'] = 'false'

def prefork_some_jazz
  require File.expand_path('../../config/environment', __FILE__)
  Rails.logger.debug 'Test environment loaded.'
  Dir[Rails.root.join('spec/support/modules/**/*.rb')].each { |f| require f }
  Dir[Rails.root.join('spec/support/prefork/**/*.rb')].each { |f| require f }
  Rails.logger.debug 'Auxillary modules loaded.'

  RSpec.configure do | config |
    config.include ViewHelpers, type: :view
    config.include ViewHelpers, type: :feature
    config.include ControllerHelpers, type: :controller
    config.include ControllerHelpers, type: :feature
  end
end

def pre_run_some_jazz
  Dir[Rails.root.join('spec/support/run/**/*.rb')].each { |f| require f }
end

def run_locally
  puts "[I #{DateTime.now.to_s}] Coverage will be run."
  require 'simplecov'
  SimpleCov.start 'rails'
  prefork_some_jazz
  pre_run_some_jazz
  puts "[I #{DateTime.now.to_s}] Preconfiguration for isolated test complete." 
end

def run_with_spork
  require 'spork'
  Spork.prefork do
    prefork_some_jazz
  end

  Spork.each_run do
    pre_run_some_jazz
  end
end

run_with_spork if ENV['DRB']
run_locally unless ENV['DRB']
