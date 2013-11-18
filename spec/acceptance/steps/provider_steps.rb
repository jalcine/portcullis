module ProviderSteps 
  step 'Provider :provider gets the user' do | provider |
  end

  step 'Provider :provider fails to get the user' do | provider |
  end

  step 'A new user should be created from data from :provider' do | provider |
  end
end

RSpec.configure { |c| c.include ProviderSteps }
