module AuthenticationSteps
  step 'a :role is signed in' do | role = 'guest' |
    @user = create :user, role.to_sym
    send 'I go to the sign-in page'
    send 'I sign in with an existing account'
  end

  step 'a :role is signed up' do | role = 'guest' |
    @user = build :user, role.to_sym
    send 'I go to the sign-up page'
    send 'I sign up with a new account'
    @user.add_role role
  end

  step 'I sign in with an existing account' do
    send 'I go to the sign-in page'
    send 'I enter my e-mail address and password'
    click_button 'Sign In'
    #send 'I click the "Sign In" button'
    send 'I am signed in'
  end

  step 'I sign up with a new account' do
    send 'I go to the sign-up page'
    send 'I enter my e-mail address and password'
    send 'I enter my name'
    send 'I enter my password confirmation'
    step 'I click the "Sign Up" button'
    send 'I am signed up'
  end

  step 'the user signs out' do
    visit destroy_user_sessions_path
    session.reset_sessions!
  end

  step 'I have a pre-existing user account' do
    @user = create :user
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
    fill_in 'user[password_confirmation]', with: @user.password
  end

  step 'I am signed in' do
    expect(page).to have_content 'Sign Out'
    expect(page).to have_content 'Signed in successfully.'
    @user = User.find_by_email(@user.email)
    expect(@user).to_not be_nil
  end

  step 'I am signed up' do
    expect(page).to have_content 'Sign Out'
    expect(page).to have_content 'signed up successfully.'
    @user = User.find_by_email(@user.email)
    expect(@user).to_not be_nil
  end
end

RSpec.configure { |c| c.include AuthenticationSteps  }
