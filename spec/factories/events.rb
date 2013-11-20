FactoryGirl.define do
  factory :event do
    name        { Faker::Lorem.words Random.rand(5) }
    description { Faker::Lorem.paragraph 3 }
    #date_start  { DateTime.now + 20.days }
    #date_end    { date_start + 20.days }
  end
end
