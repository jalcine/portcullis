require 'database_cleaner'

RSpec.configure do | config |
  DatabaseCleaner.logger = Rails.logger

  config.before(:suite) do | suite |
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do | arun |
    DatabaseCleaner.start
  end

  config.after(:each) do | arun |
    DatabaseCleaner.clean
  end
end
