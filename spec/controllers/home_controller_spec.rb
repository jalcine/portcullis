require 'spec_helper'

describe HomeController do
  describe 'GET landing' do
    it "returns http success" do
      get 'landing'
      expect(response).to be_success
    end

    it 'shows the home page' do
      allow(Settings.toggles).to receive(:in_beta).and_return(false)
      get 'landing'
      expect(response).to render_template('home/index')
    end

    it 'redirects to dashboard' do
      login_user
      get 'landing'
      expect(response).to be_redirect
    end
  end

  describe 'GET about' do
    it 'returns http success' do
      get 'about'
      expect(response).to be_success
    end

    it 'renders the about template' do
      get 'about'
      expect(response).to render_template('home/about')
    end
  end

  describe 'GET *a' do
    before(:each) do
      allow(Rails.env).to receive(:production?).and_return(true)
    end

    it 'returns http success' do
      visit 'foobar'
      expect(response.status).to be(200)
    end

    xit 'renders the 404 page' do
      visit 'foobar' 
      expect(response).to render_template('errors/500')
    end
  end
end
