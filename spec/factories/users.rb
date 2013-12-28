FactoryGirl.define do
  factory :user, aliases: [:owner] do
    email                  { Faker::Internet.email }
    password               { "#{Faker::Lorem.word}-#{email}" }
    password_confirmation  { password }

    [:guest, :host, :attendee, :administrator].each do | role |
      trait role do
        after(:create) do | user, env |
          user.revoke :guest
          user.grant role.to_sym
          user.save! 
        end
      end
    end
  end
end
