module VisualSteps
  step 'I go to the sign-in page' do
    visit '/login'
  end

  step 'I go to the sign-up page' do
    visit '/join'
  end

  step 'I sign in with :provider' do
    visit '/login'
    click_link provider
  end

  step 'I should see an error' do
    expect(page).to match /error/
  end
end

RSpec.configure do | config |
  config.include VisualSteps
end
