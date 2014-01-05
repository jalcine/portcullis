module TicketSteps
  step 'I add :number :type tickets to the event named :ticket' do | number, type, ticket |
    click_link 'Add Tickets'
    expect(page).to have_content 'Add Ticket For Event'

    within 'form[data-ticket]' do
      case type.downcase.to_s
      when :free
        click_link 'Free', exact: true
      when :priced
        click_link 'Paid', exact: true
      when :donational
        click_link 'Donation', exact: true
      end

      fill_in 'ticket[name]',        with: ticket
      fill_in 'ticket[quantity]',    with: number
      fill_in 'ticket[description]', with: Faker::Lorem.paragraphs(3).join("\n")

      within('#pricer + .row') do
        first('#ticket_day_start').click
        expect(find('#ticket_day_start + .picker')).to be_visible
        find(".picker__day.picker__day--today[data-pick='#{Time.now.midnight.to_i * 1e3.to_i}']").trigger 'click'

        first('#ticket_time_start').click
        expect(find('#ticket_time_start + .picker')).to be_visible
        find(".picker__list-item[data-pick='480']}").trigger 'click'
      end

      within('#pricer + .row + .row') do
        first('#ticket_day_end').click
        expect(find('#ticket_day_end + .picker')).to be_visible
        find(".picker__day[data-pick='#{Time.now.midnight.to_i * 1e3.to_i}']").trigger 'click'

        first('#ticket_time_end').click
        expect(find('#ticket_time_end + .picker')).to be_visible
        find(".picker__list-item[data-pick='900']}").trigger 'click'
      end

      find_button('Save Ticket').trigger 'click'
      expect(page).to have_content 'Saving Ticket'
      expect(page).to_not have_content 'Save Ticket'
    end

    expect(find('form[data-ticket]')).to_not be_visible
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
