require 'rubygems'
require 'spork'
require 'spork/ext/ruby-debug'
require 'rspec'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end

Spork.prefork do
end

Spork.each_run do
end
