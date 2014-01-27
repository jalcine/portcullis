require 'spec_helper'

describe 'users/sessions/new.html.haml' do
  before(:each) do
    allow(view).to receive(:resource_name).and_return(:user)
    allow(view).to receive(:resource).and_return(create(:user))
    handle_devise
  end

  describe 'the buttons' do
    Settings.authentication.providers.each do | provider, _ |
      next unless Settings.toggles.features.include? "auth:#{provider}"
      before(:each) { render }
      it { expect(rendered).to have_selector 'i.icon' }
      it { expect(rendered).to match /Sign In With/ }
      it { expect(rendered).to have_selector ".page.buttons > a.#{provider}" }
    end
  end

  describe 'repopulate fields' do
    before(:each) { render }
  end
end
