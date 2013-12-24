module EventSteps
  step 'I go to the new events page' do
    expect(@current_user).to_not be_nil
    visit new_event_path
    ['Location', 'Content', 'Timing', 'Classification', 'Tickets'].each do | region |
      expect(page).to have_content region 
    end
  end
 
  step 'I go to the edit events page' do
    visit edit_event_path(@event)
    expect(find('form.edit_event')).to_not be_nil
  end
 
  step 'I set the event\'s description to some placeholder text' do
    awesome_description_text = Faker::Lorem.paragraphs.join("\n")
    fill_in 'Description', with: awesome_description_text
    expect(find('#event_description').value).to eq awesome_description_text
  end

  step 'I populate the time range for the event' do
    date_start = Time.now + Random.rand(20).to_i.days
    date_end = date_start + Random.rand(15).to_i.hours
    page.evaluate_script("alert($('#start_day'))")
    screenshot_and_open_image
  end

  step "I set the event's title with :title" do | title |
    fill_in 'event[name]', with: title
    expect(find('#event_name').value).to eq title
  end

  step 'I add :number :type tickets to the event named :ticket' do | number, type, ticket |
    click_link 'Add Tickets'
    expect(page).to have_content 'Add Ticket For Event'

    case type.downcase.to_s
    when :free
      click_link 'Free', exact: true
    when :paid
      click_link 'Paid', exact: true
    when :donation
      click_link 'Donation', exact: true
    end

    fill_in 'ticket[name]',        with: ticket
    fill_in 'ticket[quantity]',    with: number
    fill_in 'ticket[description]', with: Faker::Lorem.paragraphs(3).join("\n")
    screenshot_and_open_image
    find_button('Create Ticket').trigger 'click'
  end

  step 'I have should :number tickets' do | count |
    expect(assign(:event).tickets.count).to eq(count)
  end

  step 'I have a pre-existing event' do
    @event = create :event, :with_tickets
  end

  step 'it should create a new event' do
    expect(page).to have_content 'successfully updated'
  end

  step 'I confirm creation of the event' do
    within 'form.edit_event' do
      click_on 'Create Event'
    end
  end

  step 'It should show the new event page' do
    expect(page).to have_content 'New Event'
  end
end

RSpec.configure { |config| config.include EventSteps }
