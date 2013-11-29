module AuthenticationSteps
  step 'I sign in with :provider' do | provider |
    visit new_user_session_path
    click_link "Sign In With #{provider.capitalize}"
  end

  step "there's a user signed in" do
    user = FactoryGirl.create :user, {password: 'kittykate39'}
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'kittykate39'
    click_button 'Sign In'
  end

  step 'the user signs out' do
    visit destroy_user_sessions_path
  end
end

RSpec.configure { |c| c.include AuthenticationSteps  }
