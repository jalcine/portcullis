require 'fake_braintree'

RSpec.configure do | c |
  c.before(:each) do | run |
    FakeBraintree.clear!
    FakeBraintree.verify_all_cards!
  end
end
