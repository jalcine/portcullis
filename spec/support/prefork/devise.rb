require 'devise'
require 'rspec/core'

RSpec.configure do | config |
  config.include Devise::TestHelpers, type: :controller
end
