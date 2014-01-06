module ProfileSteps
  step 'I enter my name' do
    fill_in 'profile[first_name]', with: Faker::Name.first_name
    fill_in 'profile[last_name]', with: Faker::Name.last_name

    unless first('input[name="profile[middle_name]"]').nil?
      fill_in 'profile[middle_name]', with: Faker::Name.last_name
    end
  end

  step 'I should have a profile' do
    expect(@user).to_not be_nil
    puts ap(@user.providers) if @user.profile.nil?
    expect(@user.profile).to_not be_nil
  end
end

RSpec.configure { |c| c.include ProfileSteps  }
