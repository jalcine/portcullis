require 'spec_helper'

describe 'tickets/new.html.haml' do
  let(:event)   { FactoryGirl.create :event }
  let(:ticket)  { FactoryGirl.create(:ticket, event: event) }
  let(:form)    { page.find("form#new_ticket_#{ticket.id}") }

  before(:each) do
    assign(:event, event)
    assign(:ticket, ticket)
    render
  end

  describe 'cues' do
    it { expect(page).to have_selector 'form.new_ticket' }
    it { expect(page).to have_selector 'form.new_ticket h2' }
  end

  describe 'fields' do
    it { expect(form).to have_selector 'button[type=submit]' }

    describe 'pricing buttons' do
      it { expect(form).to match /Free/ }
      it { expect(form).to match /Donation/ }
      it { expect(form).to match /Priced/ }
      it { expect(form).to have_selector 'a#price_donation' }
      it { expect(form).to have_selector 'a#price_free' }
      it { expect(form).to have_selector 'a#price_priced' }
    end

    it { expect(form).to have_selector 'input[name="ticket[name]"]' }
    it { expect(form).to have_selector 'label[for="ticket_name"]' }
    it { expect(form).to have_selector 'input[name="ticket[name]"]' }
    it { expect(form).to have_selector 'label[for="ticket_price"]' }
    it { expect(form).to have_selector 'input[name="ticket[price]"]' }
    it { expect(form).to have_selector 'label[for="ticket_description"]' }
    it { expect(form).to have_selector 'textarea[name="ticket[description]"]' }

    describe 'timing window' do
      it { expect(form).to have_selector 'label[for="ticket_date_start"]' }
      it { expect(form).to have_selector 'input[name="ticket[date_start]"]' }
      it { expect(form).to have_selector 'label[for="ticket_date_end"]' }
      it { expect(form).to have_selector 'input[name="ticket[date_end]"]' }
    end

    describe 'quotas' do
      it { expect(form).to have_selector 'label[for="ticket_quantity]' }
      it { expect(form).to have_selector 'input[name="ticket[quantity]"]' }
      it { expect(form).to have_selector 'label[for="ticket_max_quantity]' }
      it { expect(form).to have_selector 'input[name="ticket[max_quantity]"]' }
    end
  end
end
