FactoryGirl.define do
  factory :transaction do
    merchant { create(:user) }

    after(:build) do | trs, _ |
      3.times { trs.orders << create(:order) }
    end

    trait :authorized do
      after(:create) do | trs, _ |
        trs.authorize!
      end
    end
  end
end
