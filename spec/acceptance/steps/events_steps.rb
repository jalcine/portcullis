module EventSteps
  step 'I go to the new events page' do
    visit new_event_path
    pending 'ensure that navigation happened'
  end
end

RSpec.configure do | config |
  config.include EventSteps
end
