FactoryGirl.define do
  factory :event do
    user
    name        { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(3) }
    date_start  { Time.now }
    date_end    { date_start }
  end
end
