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
        fill_in 'ticket[price]', with: Random.rand(Time.now.year).to_i
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

      fill_in 'ticket[date_start]', with: Time.zone.now.to_s
      fill_in 'ticket[date_end]', with: Time.zone.now.to_s
      page.save_screenshot selector: 'form[data-ticket]'
      click_button 'Save Ticket'
    end

    find('body').synchronize do
      page.evaluate_script('$.active') == 0
    end
  end

  step 'I pick the first ticket to order' do
    id = 0
    within 'ul.ticket-list' do
      id = page.evaluate_script "$('ul.ticket-list > li.ticket:first-child').attr('data-ticket-id')"
    end
    @ticket = Ticket.find(id)
  end

  step 'I choose to order :number ticket(s) on the event page' do | number |
    within "li.ticket[data-ticket-id='#{@ticket.id}']" do
      input_field = find('input[data-ticket=quantity]')
      input_field.set number.to_i
    end
  end

  step 'the event has a ticket named :name' do | name |
    within 'ul.ticket-list' do
      expect(page).to have_content(name)
    end
  end

  step 'I pick multiple tickets to order' do
    pending
  end
  
  step 'I enter :number for donation' do | number |

  end

  step 'I see a confirmation to order the tickets' do
    expect(page).to have_content 'Confirm Order'
  end

  step 'I click to edit the ticket named :name' do | name |
    pending
  end
end

RSpec.configure { | c | c.include TicketSteps }
