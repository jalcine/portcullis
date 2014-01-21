require 'fake_braintree'

RSpec.configure do | config |
  config.before(:each) do
    braintree_config = example.metadata[:braintree]
    FakeBraintree.clear!
    FakeBraintree.decline_all_cards! if braintree_config == :decline
    FakeBraintree.verify_all_cards! if braintree_config == :verify
  end
end if defined?(FakeBraintree)
