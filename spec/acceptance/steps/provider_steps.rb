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
    send 'I go to the sign-up page'
    provider = provider.to_s.downcase
    expect(find("a.#{provider}")).to_not be_nil
    click_link "Sign Up With #{provider.capitalize}"
    expect(page).to have_content 'Sign Out'
    @provider = Provider.where(name: provider.to_s).last
    expect(@provider).to_not be_nil
    @user = @provider.user
    expect(@user).to_not be_nil
    @user.create_profile attributes_for(:profile)
  end

  step 'I can sign in/up using :provider' do | provider |
    expect(@user.providers.where(name: provider)).to_not be_nil
  end

  step 'I have a pre-existing account with :provider' do | provider |
    @user = build(:user)
    @user.providers << build(:provider, provider.to_sym)
    @user.create_profile attributes_for(:profile)
    @user.save!
  end
end

RSpec.configure { |c| c.include ProviderSteps }
