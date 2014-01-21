FactoryGirl.define do
  factory :order do
    user        { create(:attendee_user) }
    paying_user { user }
    ticket      { create(:available_ticket) }
    charge      { ticket.price }
  end
end
