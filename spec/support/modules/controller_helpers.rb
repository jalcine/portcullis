module ControllerHelpers
  def login_admin(admin = FactoryGirl.create(:user, :role_admininstrator))
    sign_in admin
  end

  def login_user(user = FactoryGirl.create(:user))
    sign_in user
  end

  def stub_env_for_devise(user_role = :user)
    request.env['devise.mapping'] = Devise.mappings[user_role]
  end

  def stub_env_for_omniauth(provider = :facebook)
    oa = FactoryGirl.build(:oauth_data, provider)
    denv = {
      'provider' => provider.to_s,
      'uid' => (Random.rand(8.8e5) + 1.1e6).round,
      'info' => oa,
      'credentials' => oa['credentials']
    }
    denv['info'] = denv['info'].except! 'credentials'
    request.env['omniauth.auth'] = denv
  end

  def stub_env_for_omniauth_params(paramaters)
    request.env['omniauth.params'] = paramaters
  end
end
