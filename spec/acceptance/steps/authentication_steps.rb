module AuthenticationSteps
  step 'I sign in with :provider' do | provider |
    find("a.#{provider.downcase}").trigger 'click'
  end

  step 'I sign up with :provider' do | provider |
    find("a.#{provider.downcase}").trigger 'click'
  end

  step "there's a user signed in" do
    user = FactoryGirl.create :user, {password: 'kittykate39'}
    visit '/login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'kittykate39'
    click_button 'Sign In'
  end

  step 'the user signs out' do
    session.reset_sessions!
    visit destroy_user_sessions_path
  end

  step 'the provider is bound to fail' do
    pending
  end

  step 'A new user should be created from data from :provider' do | provider |
    pending
    expect(Provider.where(name: provider.downcase)).to_not be_empty
  end
end

RSpec.configure { |c| c.include AuthenticationSteps  }
