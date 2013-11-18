module SignInSteps
  step 'I sign in with :provider' do | provider |
    visit "/auth/#{provider}"
  end
end

RSpec.configure { |c| c.include SignInSteps  }
