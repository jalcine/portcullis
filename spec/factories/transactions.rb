FactoryGirl.define do
  factory :transaction do
    merchant { create(:user) }

    after(:build) do | trs, _ |
      3.times { trs.orders << create(:order) }
    end
  end
end
