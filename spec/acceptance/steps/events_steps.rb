module EventSteps
  step 'I go to the new events page' do
    visit new_event_path
    pending 'ensure that navigation happened'
  end

  step 'it updates the internal start timestamp'
  step 'it updates the internal end timestamp'
  step 'I have should :number tickets' do | count |

  end
end

RSpec.configure { |config| config.include EventSteps }
