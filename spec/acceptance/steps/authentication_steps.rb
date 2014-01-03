module AuthenticationSteps
  step 'I sign in with :provider' do | provider |
    send 'I go to the sign-in page'
    expect(find("a.#{provider.downcase}")).to_not be_nil
    find("a.#{provider.downcase}").trigger 'click'
  end

  step 'I sign up with :provider' do | provider |
    send 'I go to the sign-up page'
    expect(find("a.#{provider.downcase}")).to_not be_nil
    find("a.#{provider.downcase}").trigger 'click'
  end

  step 'a :role is signed in' do | role = 'guest' |
    @user = create :user, role.to_sym
    send 'I go to the sign-in page'
    send 'I sign in with an existing account'
  end

  step 'a :role is signed up' do | role = 'guest' |
    @user = build :user, role.to_sym
    send 'I go to the sign-up page'
    send 'I sign up with a new account'
  end

  step 'the user signs out' do
    visit destroy_user_sessions_path
    session.reset_sessions!
  end

  step 'I have a pre-existing user account' do
    @user = create :user
  end

  step 'the provider is bound to fail' do
    pending 'make provider creation fail'
  end

  step 'A new user should be created from data from :provider' do | provider |
    pending "Handle logic for determing existence from #{provider} data."
  end

  step 'I enter my e-mail address and password' do
    @user = build :user, { 
      email: Faker::Internet.email,
      password: "#{Faker::Lorem.sentence}**%#{Random.rand(Time.now.year * Time.now.hour)}"
    } if @user.nil?

    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
  end

  step 'I enter my password confirmation' do
    fill_in 'Password confirmation', with: @user.password
  end

  step 'I sign up for a new account' do
    send 'I enter my e-mail address and password'
    send 'I enter my password confirmation'
    send 'I click the "Sign Up" button'
    send 'I am signed up'
  end

  step 'I sign in with an existing account' do
    send 'I enter my e-mail address and password'
    send 'I click the "Sign In" button'
    send 'I am signed in'
  end

  step 'I am signed in' do
    expect(page).to have_content 'Sign Out'
    expect(page).to have_content 'Signed in successfully.'
  end

  step 'I am signed up' do
    expect(page).to have_content 'Sign Out'
    expect(page).to have_content 'signed up successfully.'
  end
end

RSpec.configure { |c| c.include AuthenticationSteps  }
