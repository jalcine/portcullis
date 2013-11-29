module RoutingSteps
  step 'I go to the sign-up page' do
    visit new_user_registration_path
  end

  step 'I go to the sign-in page' do
    visit new_user_session_path
  end
end

RSpec.configure { |c| c.include RoutingSteps  }