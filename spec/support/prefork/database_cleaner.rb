require 'database_cleaner'

RSpec.configure do | config |
  DatabaseCleaner.logger = Rails.logger

  config.before(:suite) do | suite |
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do | a_run |
    is_turnip = a_run.example.metadata[:turnip]
    DatabaseCleaner.start if is_turnip == false
  end

  config.after(:each) do | a_run |
    is_turnip = a_run.example.metadata[:turnip]
    DatabaseCleaner.clean if is_turnip == false
  end
end
