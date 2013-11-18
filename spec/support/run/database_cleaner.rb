require 'database_cleaner'

RSpec.configure do | config |
  config.before(:each) do | arun |
    DatabaseCleaner.start
  end

  config.after(:each) do | arun |
    DatabaseCleaner.clean
  end
end
