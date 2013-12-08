FactoryGirl.define do
  factory :provider do
    name 'foobar'
    user   { FactoryGirl.create :user }
    uid    { Random.rand(1e8) }
    token  { Random.rand(1e7) }

    trait :facebook do
      name 'facebook'
    end

    trait :gplus do
      name 'gplus'
    end

    trait :linkedin do
      name 'linkedin'
    end

    factory :facebook_provider, traits: [:facebook]
    factory :gplus_provider, traits: [:gplus]
    factory :linkedin_provider, traits: [:linkedin]
  end
end
