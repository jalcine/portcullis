FactoryGirl.define do
  factory :avatar_uploader do
    file File.open("#{Rails.root}/spec/support/images/kittykat.jpg")
  end
end
