RSpec.configure do | config |
  config.include Warden::Test::Helpers
  config.include Warden::Test::Helpers, type: :feature
end

Warden.test_mode!
