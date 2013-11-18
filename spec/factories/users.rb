FactoryGirl.define do
  factory :user do
    email                  { Faker::Internet.email }
    password               { "#{Faker::Name.first_name}-#{email}" }
    password_confirmation  { "#{password}" }

    [:booker, :performer].each do | role |
      trait :booker do
        after(:create) do | user, env |
          user.grant role
          user.save! 
        end
      end
    end
  end
end
