require 'spec_helper'

describe 'users/registrations/new.html.haml' do
  before(:each) do
    allow(view).to receive(:resource_name).and_return(:user)
    allow(view).to receive(:resource).and_return(FactoryGirl.create(:user))
    handle_devise
  end

  describe 'the buttons' do
    Settings.authentication.providers.each do | provider, _ |
      before(:each) { render }
      it { expect(rendered).to have_selector 'i.icon' }
      it { expect(rendered).to match /Sign Up/ }
      it { expect(rendered).to have_selector ".page.buttons > a.#{provider}" }
    end
  end
end
