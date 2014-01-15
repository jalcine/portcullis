class User < ActiveRecord::Base
  include Roleable
  include Customer

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => Settings.authentication.providers.map { |i, __| i.to_sym }

  validates :password, presence: true, allow_nil: false, allow_blank: true, if: :password_required?
  validates :email, presence: true, if: :email_required?

  def password_required?
    self.providers.empty?
  end

  def email_required?
    password_required?
  end

  has_one :profile
  has_many :providers
  has_many :events
  has_many :tickets

  class << self
    def build_with_oauth(oauth_data)
      return nil if oauth_data.nil?
      return nil unless (oauth_data.keys.include? 'provider' or oauth_data.keys.include? :provider)
      return nil unless (oauth_data.keys.include? 'uid' or oauth_data.keys.include? :uid)

      params = ActionController::Parameters.new(email: oauth_data['info']['email'])
      user = User.new params.permit!
      provider = user.providers.build name: oauth_data['provider'].to_s,
        token: oauth_data['credentials']['token'].to_s,
        uid: oauth_data['uid'].to_s
      provider.user = user
      provider.save!
      user.save!
      user
    end

    def find_by_oauth(oauth_data)
      return nil unless !oauth_data.nil?
      return nil unless (oauth_data.keys.include? 'provider' or oauth_data.keys.include? :provider)
      return nil unless (oauth_data.keys.include? 'uid' or oauth_data.keys.include? :uid)
      provider = Provider.where({name: oauth_data['provider'].to_s, uid: oauth_data['uid']}).first
      return provider.user unless provider.nil?
      nil
    end
  end

  public
    def permissions_for(provider_name)
      # NOTE This is only applied for Facebook. If we don't have the provider
      # for any other service, we assume that we couldn't get any data.
      provider = providers.where(name: provider_name)
      return nil if provider.nil?

      if provider_name.to_sym == :facebook then
        querying_uri = Settings.authentication.providers[provider_name][:permissions_uri]
        querying_uri = querying_uri.replace '%uid', provider.uid
        querying_uri = querying_uri.replace '%token', provider.token

        ret = HTTParty.get(querying_uri)
        return ret.parsed_response['data']
      else
        return Settings.authentication.providers[provider_name][:scope]
      end

      nil
    end
end
