module AuthenticationSteps
  step 'I sign in with :provider' do | provider |
    visit new_user_session_path
    click_link "Sign In With #{provider.capitalize}"
  end

  step 'I sign up with :provider' do | provider |
    visit new_user_registration_path
    click_link "Sign Up With #{provider.capitalize}"
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

  step 'the provider is bound to fail' do
    @bound_to_fail = true
  end

  step 'A new user should be created from data from :provider' do | provider |
    expect(Provider.where(name: provider)).to_not be_empty
  end
end

RSpec.configure { |c| c.include AuthenticationSteps  }
