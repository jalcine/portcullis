FactoryGirl.define do
  factory :transaction do
    merchant { create(:host_user) }

    after(:build) do | trs, _ |
      Random.rand(Time.now.hour + 4).to_i.times { 
        trs.orders << create(:order, transaction: trs)
      }
    end

    trait :authorized do
      after(:create) { | t, _ | t.authorize! }
    end
  end
end
