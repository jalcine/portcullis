require 'braintree'

Braintree::Configuration.environment = Settings.braintree.env.to_sym
Braintree::Configuration.merchant_id = Settings.braintree.merchant_id
Braintree::Configuration.public_key  = Settings.braintree.key.public
Braintree::Configuration.private_key  = Settings.braintree.key.private
