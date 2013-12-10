module RoutingSteps
  step 'I go to the sign-up page' do
    pending
    visit '/join'
  end

  step 'I go to the sign-in page' do
    pending
    visit '/login'
  end
end

RSpec.configure { |c| c.include RoutingSteps  }
