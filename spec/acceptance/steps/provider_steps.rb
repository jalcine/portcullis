module ProviderSteps
  step 'I sign in with :provider' do | provider, state |
    send 'I go to the sign-in page'
    expect(find("a.#{provider.downcase}")).to_not be_nil
    expect(find("a.#{provider.downcase}")).to_not be_nil
    click_link "Sign In With #{provider.capitalize}"
    @user = User.first
    expect(@user).to_not be_nil
  end

  step 'I sign up with :provider' do | provider |
    a_email = Faker::Internet.email
    send 'I go to the sign-up page'
    expect(find("a.#{provider.downcase}")).to_not be_nil
    click_link "Sign Up With #{provider.capitalize}"
    @user = User.first
    expect(@user).to_not be_nil
  end

  step 'I can sign in/up using :provider' do | provider |
    provider = provider.downcase.to_s
    providers = @user.providers.where(name: provider.to_s)
    expect(providers).to_not be_nil
    expect(providers).to_not be_empty
  end
end

RSpec.configure { |c| c.include ProviderSteps }
