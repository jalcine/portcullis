FactoryGirl.define do
  factory :user, aliases: [:owner] do
    email                  { Faker::Internet.email }
    password               { "#{Faker::Name.first_name}-#{email}" }
    password_confirmation  { password }

    [:guest, :host, :attendee, :administrator].each do | role |
      factory "#{role}_user".to_sym do
        after(:create) do | user, env |
          user.revoke :guest
          user.grant role.to_sym
          user.save! 
        end
      end
    end
  end
end
