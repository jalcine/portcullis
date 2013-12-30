module TicketSteps
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
    find_button('Create Ticket').trigger 'click'
  end

  step "the event has a :type ticket named :name" do | type, name |
    expect(page).to have_content(name)
  end
end

RSpec.configure { | c | c.include TicketSteps }
