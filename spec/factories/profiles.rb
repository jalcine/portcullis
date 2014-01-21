FactoryGirl.define do
  factory :profile do
    user           { create(:user) }
    first_name     { Faker::Name.first_name }
    last_name      { Faker::Name.last_name }
    middle_name    { Faker::Name.first_name }
    date_of_birth  { DateTime.now - 23.years }
    address        { Faker::Address.street_address }
    phone_number   { Faker::PhoneNumber.cell_phone }

    after(:create) do | profile, eval |
      profile.avatar = FactoryGirl.attributes_for(:avatar_uploader)['file']
    end

    trait :paying do
      after(:create) do | p, e |
        customer = p.user.to_customer
        expiry_date = Faker::Business.credit_card_expiry_date
        Braintree::Customer.update(
          customer.id,
          credit_card: {
            cardholder_name: "#{p.first_name} #{p.last_name}",
            number: Faker::Business.credit_card_number,
            expiration_date: "#{expiry_date.month}/#{expiry_date.year}"
          }
        )
      end
    end

    factory :paying_profile, traits: [:paying]
  end
end
