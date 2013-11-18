FactoryGirl.define do
  factory :profile do
    first_name     { Faker::Name.first_name }
    last_name      { Faker::Name.last_name }
    middle_name    { Faker::Name.first_name }
    date_of_birth  { DateTime.now - 23.years }
    address        { Faker::Address.street_address }
    phone_number   { Faker::PhoneNumber.cell_phone }

    after(:create) do | profile, eval |
      profile.avatar = FactoryGirl.attributes_for(:avatar_uploader)['file']
    end
  end
end
