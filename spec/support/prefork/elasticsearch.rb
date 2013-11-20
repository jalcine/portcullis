RSpec.configure do | config |
  config.before(:suite) do | suite |
    Event.tire.index.delete
    Event.create_elasticsearch_index
  end

  config.before(:each) do | arun |
    Event.tire.index.refresh
  end

  config.after(:each) do | arun |
    Event.tire.index.delete
    Event.create_elasticsearch_index
  end
end
