module MiscelleanousSteps
  step 'I should see an error' do
  end

  step 'I should see a message indicating :message' do | message |
  end

  step 'I should not see the event called :name in the event list' do
  end
end

RSpec.configure { |c| c.include MiscelleanousSteps }
