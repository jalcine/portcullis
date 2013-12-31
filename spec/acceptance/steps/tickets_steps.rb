module TicketSteps
  step 'I add :number :type tickets to the event named :ticket' do | number, type, ticket |
    click_link 'Add Tickets'
    expect(page).to have_content 'Add Ticket For Event'

    within 'form[data-ticket]' do
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

      first('#ticket_day_start').click
      expect(find('#ticket_day_start + .picker')).to be_visible
      screenshot_and_open_image
      puts ".picker__day[data-pick='#{Time.now.midnight.to_i}']"
      find(".picker__day[data-pick='#{Time.now.midnight.to_i}]'").trigger 'click'
      expect(find('.picker')).to_not be_visible

      first('#ticket_time_start').click
      expect(find('.picker')).to be_visible
      find(".picker__list-iem[data-pick=60]}").trigger 'click'
      click_link '8:00 AM'
      expect(find('.picker')).to_not be_visible

      first('#ticket_day_end').click
      expect(find('.picker')).to be_visible
      find(".picker__day[data-pick=#{(Time.now + 2.days).midnight.to_i}]").trigger 'click'
      expect(find('.picker')).to_not be_visible

      first('#ticket_time_end').click
      expect(find('.picker')).to be_visible
      find(".picker__list-iem[data-pick=60]}").trigger 'click'
      expect(find('.picker')).to_not be_visible

      find_button('Save Ticket').trigger 'click'
      expect(page).to have_content 'Saving Ticket'
      expect(page).to_not have_content 'Save Ticket'
    end
    expect('form[data-ticket]').to_not be_visible
    screenshot_and_open_image
  end

  step 'the event has a :type ticket named :name' do | type, name |
    within 'li[data-ticket]' do
      expect(page).to have_content(name)
    end
  end

  step 'I click to edit the ticket named :name' do | name |
    Rails.logger.debug Ticket.find_by_name(name)
  end
end

RSpec.configure { | c | c.include TicketSteps }
