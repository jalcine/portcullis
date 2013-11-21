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
    #puts find('form#omnisearch input[name=query]')
    #click_button 'Search'
  end

  step 'I should see a message indicating no events were found' do
    pending
    within '#event_list' do
      expect(page).to have_content('No events were found')
    end
  end
  
  step 'I should not see the event called :event_name in the event list' do | event_name |
    pending
    within '#event_list' do
      expect(page).to_not have_content :event_name
    end
  end

  step 'I should see the event called :event_name in the event list' do | event_name |
    pending
    within '#event_list' do
      expect(page).to have_content :event_name
    end
  end
end

RSpec.configure do | config |
  config.include SearchSteps
end
