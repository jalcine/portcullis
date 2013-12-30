require 'spec_helper'

describe 'tickets/_form.html.haml' do
  let(:event)   { FactoryGirl.create :event }
  let(:ticket)  { FactoryGirl.create(:ticket, event: event) }

  before(:each) do
    assign(:event, event)
    assign(:ticket, ticket)
    render
  end

  describe 'visual cues' do
    it 'has a rendered form' do
      expect(rendered).to have_selector 'form'
    end
  end

  describe 'fields' do
    it { expect(rendered).to have_selector 'button[type=submit]' }

    describe 'pricing buttons' do
      it { expect(rendered).to match /Free/ }
      it { expect(rendered).to match /Donation/ }
      it { expect(rendered).to match /Paid/ }
      it { expect(rendered).to have_selector 'span#price_donation' }
      it { expect(rendered).to have_selector 'span#price_free' }
      it { expect(rendered).to have_selector 'span#price_fixed' }
    end

    it { expect(rendered).to have_selector 'input[name="ticket[name]"]' }
    it { expect(rendered).to have_selector 'input[name="ticket[name]"]' }
    it { expect(rendered).to have_selector 'input[name="ticket[price]"]' }
    it { expect(rendered).to have_selector 'textarea[name="ticket[description]"]' }

    describe 'timing window' do
      it { expect(rendered).to have_selector 'input[name="ticket[date_start]"]' }
      it { expect(rendered).to have_selector 'input[name="ticket[date_end]"]' }
    end

    describe 'quotas' do
      it { expect(rendered).to have_selector 'input[name="ticket[quantity]"]' }
      it { expect(rendered).to have_selector 'input[name="ticket[infinite]"]' }
    end
  end
end
