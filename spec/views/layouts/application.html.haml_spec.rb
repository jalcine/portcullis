require 'spec_helper'

describe 'layouts/application.html.haml' do 
  before(:each) do
    add_view_path "#{Rails.root}/spec/support/views"
    view.stub(:user_signed_in?).and_return(:true)
    controller.request.params.stub(
      controller: 'layouts',
      action: 'application'
    )
  end

  let(:params)  { controller.request.params }

  describe 'title' do
    it 'has a subtitle' do
      view.page_title 'Subtitle'
      render
      expect(rendered).to have_title 'Subtitle - Vettio' 
    end

    it 'has a generic title' do
      render
      expect(rendered).to have_title 'Vettio'
    end
  end

  describe 'styling' do
    before(:each) do
      render template: 'layouts/application', locals: { params: params }
    end

    it 'has the controller class' do
      expect(rendered).to have_selector("body.#{params[:controller]}")
    end

    it 'has the action class' do
      expect(rendered).to have_selector("body.#{params[:action]}")
    end
  end

  describe 'sectors' do
    before(:each) do
      render template: 'layouts/application', locals: { params: {} }
    end

    it { expect(rendered).to have_selector '.sticky > nav.top-bar' }
    it { expect(rendered).to have_selector 'body footer.main[role=contentinfo]' }
    it { expect(rendered).to have_selector 'body section.main[role=contentinfo]' }
    it { expect(rendered).to have_selector 'body header.main[role=contentinfo]' }
  end
end
