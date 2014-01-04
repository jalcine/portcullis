require 'digest/sha1'

unless Rails.env.production?
  require 'faker'
  OmniAuth.config.test_mode = true

  # Provide information for providers.
  Settings.authentication.providers.each do | provider_name, __ |
    OmniAuth.config.mock_auth[provider_name.to_sym] = OmniAuth::AuthHash.new({
    provider: provider_name,
    uid: 1e9 + Random.rand(9e8).round,
    info: {
      name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
      email: Faker::Internet.email,
      nickname: Faker::Internet.user_name,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      location: "#{Faker::Address.city}, #{Faker::Address.state}",
      description: Faker::Lorem.paragraph,
      image: 'http://placekitten.com/g/800/600',
    },
    credentials: {
      token:  Digest::SHA256.hexdigest(Faker::Lorem.paragraph),
      secret: Digest::SHA256.hexdigest(Faker::Lorem.paragraph)
    }
  })
  end
end

OmniAuth.config.logger = Rails.logger
OmniAuth.config.on_failure = Users::OmniauthController.action(:failure)
