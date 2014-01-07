require 'spec_helper'

describe 'tickets/_stub.html.haml' do
  let(:event) { FactoryGirl.create :event, :with_tickets }
  let(:user)  { FactoryGirl.create :user, :attendee }
  subject     { FactoryGirl.create(:ticket, event: event) }

  before(:each) do
    handle_devise
    set_current_user_to create(:user, :attendee)
  end

  describe 'visual cues' do
    before(:each) { render partial: 'tickets/stub', locals: { ticket: subject } }
    it { expect(rendered).to have_content(subject.name) }
    it { expect(rendered).to have_content(subject.description) }
  end
end
