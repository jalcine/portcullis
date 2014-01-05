FactoryGirl.define do
  factory :provider do
    name   'developer'
    user   { FactoryGirl.create :user }
    uid    { Random.rand(1e8) }
    token  { Digest::SHA1.hexdigest(Random.rand(1e7).to_s + DateTime.now.to_s) }

    trait :facebook do
      name 'facebook'
    end

    trait :gplus do
      name 'gplus'
    end

    trait :linkedin do
      name 'linkedin'
    end
  end
end
