module EventSteps
  step 'I go to the new events page' do
    visit new_event_path
    expect(find("form.edit_event")).to_not be_nil
    @current_user.grant :host
    @current_user.save!
    expect(find('form.edit_event')).to_not be_nil
  end
  
  step 'I set the event\'s description to some placeholder text' do
    awesome_description_text = Faker::Lorem.paragraphs.join('\n')
    fill_in 'Description', with: awesome_description_text
    expect(find('#event_description').value).to eq awesome_description_text
  end

  step 'I populate the time range for the event' do
    event_day_start_field  = find('#start_day')
    event_day_end_field    = find('#end_day')
    event_time_start_field = find('#start_time')
    event_time_end_field   = find('#end_time')
  end

  step "I set the event's title with :title" do | title |
    fill_in 'Name', with: title
    expect(find('#event_name').value).to eq title
  end

  step 'I add :number :type tickets to the event named :ticket' do | number, type, ticket |
    click_link 'Add Tickets'

    case type.downcase.to_s
    when :free
      click_link 'Free', exact: true
    when :paid
      click_link 'Paid', exact: true
    when :donation
      click_link 'Donation', exact: true
    end

    fill_in 'ticket[name]', with: ticket
    fill_in 'ticket[description]', with: Faker::Lorem.paragraphs(3).join('\n')
    fill_in 'ticket[quantity]', with: number
    click_on 'Create Ticket'
  end

  step 'I have should :number tickets' do | count |
    expect(assign(:event).tickets.count).to eq(count)
  end

  step 'it should create a new event' do
    pending
  end

  step 'I confirm creation of the event' do
    within 'form.edit_event' do
      click_on 'Create Event'
    end
  end

  step 'It should show the new event page' do
    pending
  end
end

RSpec.configure { |config| config.include EventSteps }
