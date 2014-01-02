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
    @current_user_data = attributes_for :user, role.to_sym
    send 'I go to the sign-in page'
    send 'I sign in with an existing account'
  end

  step 'a :role is signed up' do | role = 'guest' |
    @current_user_data = attributes_for :user, role.to_sym
    send 'I go to the sign-up page'
    send 'I sign up with a new account'
  end

  step 'I sign up for a new account' do
    ['email', 'password', 'password_confirmation'].each do | field |
      fill_in "user[#{field}]", with: @current_user_data[field.to_sym]
      expect(find("#user_#{field}").value).to eq @current_user_data[field.to_sym]
    end

    find_button('Sign Up').click
    @current_user = User.create! @current_user_data
  end

  step 'I sign in with an existing account' do
    @current_user = User.create! @current_user_data
    ['email', 'password'].each do | field |
      fill_in "user[#{field}]", with: @current_user_data[field.to_sym]
      expect(find("#user_#{field}").value).to eq @current_user_data[field.to_sym]
    end

    click_button 'Sign In'
    expect(page).to have_content 'Signed in'
  end

  step 'the user signs out' do
    visit destroy_user_sessions_path
    session.reset_sessions!
  end

  step 'the provider is bound to fail' do
    pending 'make provider creation fail'
  end

  step 'A new user should be created from data from :provider' do | provider |
    pending "Handle logic for determing existence from #{provider} data."
  end

  step 'I enter my e-mail address and password' do
    fill_in 'Email', with: Faker::Internet.email
    fill_in 'Password', with: "#{Faker::Lorem.word}#\$/%#{Random.rand(Time.now.year * Time.now.hour)}"
  end

  step 'I should be signed in' do
    pending 'determine if the user is signed in'
  end
end

RSpec.configure { |c| c.include AuthenticationSteps  }
