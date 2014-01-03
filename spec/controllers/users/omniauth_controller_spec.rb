require 'spec_helper'

describe Users::OmniauthController do
  Settings.authentication.providers.each do |provider, options| 
    describe "GET|POST #{provider}" do
      before(:each) do
        stub_env_for_devise :user
        stub_env_for_omniauth provider.to_sym
      end

      let(:oauth_data) { request.env['omniauth.oauth'] }

      describe 'valid keys' do
        subject { request.env['omniauth.auth'] }
        it { expect(request.env.keys).to include('omniauth.auth') }
        it { expect(subject.keys).to include('provider') }
        it { expect(subject.keys).to include('uid') }
        it { expect(subject.keys).to include('info') }
        it { expect(subject.keys).to include('credentials') }
      end

      describe "signing up with #{provider}" do
        let(:the_options) { {
          'task' => 'new'
        }}

        ['task'].each do | a_key |
          describe "missing '#{a_key}' parameter" do
            before(:each) do
              stub_env_for_omniauth_params the_options.clone.except!(a_key)
              get provider
            end

            it { expect(response.status).to eq(302) }
            it { expect(flash).to_not be_empty }
            it { expect(flash.keys).to_not include :notice }
            it { expect(flash.keys).to include :error }
            it { expect(controller.current_user).to be_nil }
          end
        end
        describe 'good authentication request' do
          before(:each) do
            stub_env_for_omniauth provider.to_sym
            stub_env_for_omniauth_params the_options
            get provider
          end

          it { expect(request.env.keys).to include('omniauth.params') }
          it { expect(flash).to_not be_empty }
          it { expect(flash.keys).to_not include :error }
          it { expect(flash.keys).to include :notice }
          it { expect(response.status).to eq(302) }
          it { expect(controller.current_user).to_not be_nil }
          it { expect(controller.current_user.roles).to_not be_empty }
          it { expect(controller.current_user.roles).to_not include(:guest) }
        end
      end

      describe "signing in with #{provider}" do
        let(:the_options) { {
          'task' => 'find'
        }}

        ['task'].each do | a_key |
          describe 'missing parameters' do
            before(:each) do
              stub_env_for_omniauth_params the_options.clone.except!(a_key)
              get provider
            end

            it { expect(response.status).to eq(302) }
            it { expect(flash).to_not be_empty }
            it { expect(flash.keys).to include :error }
            it { expect(request.env['devise.mapping']).to_not be_nil }
            it { expect(User.find_by_email(request.env['omniauth.auth']['info']['email'])).to be_nil }
            it { expect(controller.current_user).to be_nil }
          end
        end

        describe 'good authentication request' do
          before(:each) do
            stub_env_for_omniauth provider.to_sym
            stub_env_for_omniauth_params the_options
            u = User.build_with_oauth request.env['omniauth.auth']
            u.create_profile FactoryGirl.attributes_for(:profile)
            u.save!
            get provider
          end

          it { expect(request.env.keys).to include('omniauth.params') }
          it { expect(response.status).to eq(302) }
          it { expect(flash).to_not be_empty }
          it { expect(flash.keys).to include :notice }
          it { expect(flash.keys).to_not include :error }
          it { expect(controller.current_user).to_not be_nil }
          it { expect(controller.current_user.roles).to_not be_empty }
          it { expect(controller.current_user.roles).to_not include(:guest) }
        end

        describe 'bad authentication request' do
          before(:each) do
            stub_env_for_omniauth provider.to_sym
            stub_env_for_omniauth_params the_options
            stub_env_for_omniauth_error provider.to_sym
            get provider
          end

          it { expect(response.status).to eq(302) }
          it { expect(flash).to_not be_empty }
          it { expect(flash.keys).to include :error }
          it { expect(flash.keys).to_not include :notice }
        end
      end

      end
    end
  end
