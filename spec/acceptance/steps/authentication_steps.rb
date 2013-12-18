module AuthenticationSteps
  step 'I sign in with :provider' do | provider |
    find("a.#{provider.downcase}").trigger 'click'
  end

  step 'I sign up with :provider' do | provider |
    find("a.#{provider.downcase}").trigger 'click'
  end

  step "there's a user signed in" do
    @current_user = FactoryGirl.attributes_for :user
    send 'I go to the sign-up page'
    fill_in 'user[email]', with: @current_user[:email]
    fill_in 'user[password]', with: @current_user[:password]
    click_button 'Sign Up'
    send 'I go to the sign-in page'
    fill_in 'user[email]', with: @current_user[:email]
    fill_in 'user[password]', with: @current_user[:password]
    click_button 'Sign In'
  end

  step 'the user signs out' do
    visit destroy_user_sessions_path
    session.reset_sessions!
  end

  step 'the provider is bound to fail' do
    pending
    # TODO: Set up provider to fail.
  end

  step 'A new user should be created from data from :provider' do | provider |
    expect(Provider.where(name: provider.downcase)).to_not be_empty
  end
end

RSpec.configure { |c| c.include AuthenticationSteps  }
