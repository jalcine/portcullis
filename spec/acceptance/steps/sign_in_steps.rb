module SignInSteps
  step 'I sign in with :provider' do | provider |
    visit "/auth/#{provider}"
  end

  step "there's a user signed in" do
    user = FactoryGirl.create :user
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
  end
end

RSpec.configure do | config |
  config.include SignInSteps
end
