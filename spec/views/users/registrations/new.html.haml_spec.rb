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
      it 'has an icon' do
        expect(rendered).to have_selector 'i.icon'
      end

      it 'tells the user to sign up' do
        expect(rendered).to match /Sign Up/
      end

      it 'corresponds with its provider' do
        expect(rendered).to have_selector ".page.buttons > a.#{provider}"
      end
    end
  end
end
