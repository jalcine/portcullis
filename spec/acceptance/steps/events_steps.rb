module EventSteps
  step 'I go to the new events page' do
    visit new_event_path
    expect(find("form.edit_event")).to_not be_nil
  end
  
  step 'I set the event\'s description to some placeholder text' do
    awesome_description_text = Faker::Lorem.paragraphs.join('\n')
    fill_in 'Description', with: awesome_description_text
    expect(find('#event_description').value).to eq awesome_description_text
  end

  step 'I populate the time range for the event' do
    event_date_start_field = find('#event_date_start')
    event_date_end_field   = find('#event_date_end')
    event_day_start_field  = find('#start_day')
    event_day_end_field    = find('#end_day')
    event_time_start_field = find('#start_time')
    event_time_end_field   = find('#end_time')
  end

  step "I set the event's title with :title" do | title |
    fill_in 'Name', with: title
    expect(find('#event_name').value).to eq title
  end

  step 'I add :number :type tickets (for :price) to the event named :ticket' do | number, type, ticket, price |
    click_link 'Add Tickets'
    fill_in 'Ticket Name', with: ticket
    case type.downcase.to_s
    when :free
      click_link 'Free'
    when :paid
      click_link 'Paid'
    when :donation
      click_link 'Donation'
    end
  end

  step 'I have should :number tickets' do | count |
    expect(assign(:event).tickets.count).to eq(count)
  end

  step 'I confirm creation of the event' do
    click_link 'Create Event'
  end
end

RSpec.configure { |config| config.include EventSteps }
