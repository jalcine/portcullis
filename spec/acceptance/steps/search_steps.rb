module SearchSteps
  step 'I am on the home page' do
    visit '/'
  end

  step 'some sample events:' do | table |
    @events = [] 
    table.hashes.each do | hash |
      @events << FactoryGirl.create(:event, hash)
    end
  end

  step 'I search for :query' do |query|
    expect(page).to have_content 'Search'
  end

  step 'I should see a message indicating no events were found' do
    pending
  end

  step 'I should not see the event called :event_name in the event list' do | event_name |
    pending
  end

  step 'I should see the event called :event_name in the event list' do | event_name |
    pending
  end
end

RSpec.configure do | config |
  config.include SearchSteps
end
