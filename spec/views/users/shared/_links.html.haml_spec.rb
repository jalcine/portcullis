require 'spec_helper'

describe 'users/shared/_links.haml' do 
  let(:params)  { controller.request.params }
  before(:each) do
    allow(view).to receive(:resource_name).and_return(:user)
    allow(view).to receive(:user_signed_in?).and_return(false)
    allow(view).to receive(:in_registrations?)
    allow(view).to receive(:in_sessions?)
    allow(view).to receive(:in_passwords?)
    handle_devise
  end

  describe 'links for sessions' do
    before(:each) do
      allow(view).to receive(:in_sessions?).and_return(:true)
      render
    end

    it { expect(rendered).to_not match /Sign in/ }
    it { expect(rendered).to match /Forgot your password\?/ }
    it { expect(rendered).to match /Sign up/ }
  end

  describe 'links for registrations' do
    before(:each) do
      allow(view).to receive(:in_registrations?).and_return(:true)
      render
    end
    it { expect(rendered).to_not match /Forgot your password\?/ }
    it { expect(rendered).to_not match /Sign up/ }
    it { expect(rendered).to match /Sign in/ }
  end

  describe 'links for passwords' do
    before(:each) do
      allow(view).to receive(:in_passwords?).and_return(:true)
      render
    end

    it { expect(rendered).to_not match /Forgot your password\?/ }
    it { expect(rendered).to_not match /Sign up/ }
    it { expect(rendered).to match /Sign in/ }
  end
end
