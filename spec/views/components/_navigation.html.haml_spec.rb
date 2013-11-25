require 'spec_helper'

describe 'components/_navigation.html.haml' do
  before(:each) { view.stub(:user_signed_in?).and_return(false) }

  describe 'the title region' do
    before(:each) { render }
    it { expect(rendered).to have_selector('nav.top-bar') }
  end

  context 'signed out' do
    let(:right_menu) { Capybara.string(rendered).find('nav.top-bar > section.top-bar-section > ul.right') }

    describe 'user authentication' do
      context 'when logged out' do
        before(:each) { view.stub(:user_signed_in?).and_return(false) }
        before(:each) { render }
        it 'shows sign in button' do
          expect(right_menu).to have_selector("li > a.sign_in[href='#{new_user_session_path}']")
        end
        it 'shows sign up button' do
          expect(right_menu).to have_selector("li > a.sign_up[href='#{new_user_registration_path}']")
        end

        it 'hides sign out button' do
          expect(right_menu).to_not have_selector('li > a.sign_out')
        end
      end

      context 'when logged in' do
        before(:each) { view.stub(:user_signed_in?).and_return(true) }
        before(:each) do
          render
        end

        it 'hides sign in button' do
          expect(right_menu).to_not have_selector('li > a.sign_in')
        end

        it 'hides sign up button' do
          expect(right_menu).to_not have_selector('li > a.sign_up')
        end

        it 'shows sign out button' do
          expect(right_menu).to have_selector('li > a.sign_out')
        end
      end
    end
  end
end
