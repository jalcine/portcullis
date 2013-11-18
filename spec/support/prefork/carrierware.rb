require 'rspec'
require 'carrierwave'
require 'carrierwave/test/matchers'

RSpec.configure do | config |
  config.include CarrierWave::Test::Matchers

  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end
