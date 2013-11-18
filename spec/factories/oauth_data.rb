FactoryGirl.define do
  factory :oauth_data, class: Hash do
    after(:build) do | hash, evaluator |
      hash['email'] = Faker::Internet.email
      hash['first_name'] = Faker::Name.first_name
      hash['last_name'] = Faker::Name.last_name
      hash['name'] = "#{hash['first_name']} #{hash['last_name']}"
      hash.except! :email
      hash['credentials'] = {
        'token' => Digest::SHA256.hexdigest("#{Faker::Internet.user_name}#{Random.rand(1e4)}"),
        'secret' => Digest::SHA256.hexdigest("#{Faker::Internet.user_name}#{Random.rand(1e5)}"),
      }
    end

    trait :facebook
    trait :gplus
  end
end
