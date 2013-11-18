class User < ActiveRecord::Base
  include Roleable

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => Settings.authentication.providers.map { |i, __| i.to_sym }

  validates :password, presence: true, allow_nil: false, allow_blank: true, if: :password_required?
  validates 'email', presence: true, if: :email_required?

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

      provider = user.providers.build name: oauth_data['provider'].to_s
      provider.token = oauth_data['credentials']['token'].to_s
      provider.uid = oauth_data['uid'].to_s
      provider.user = user
      provider.save!
      raise StandardError, 'User cannot be created with provided values.' if user.nil?
      user
    end

    def find_by_oauth(oauth_data)
      return nil unless !oauth_data.nil?
      return nil unless (oauth_data.keys.include? 'provider' or oauth_data.keys.include? :provider)
      return nil unless (oauth_data.keys.include? 'uid' or oauth_data.keys.include? :uid)
      provider = Provider.where({name: oauth_data['provider'].to_s, uid: oauth_data['uid']}).first
      return provider.user unless provider.nil?
    end
  end
end
