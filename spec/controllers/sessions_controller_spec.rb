require 'rails_helper'
require 'omniauth_spec_helper'

describe SessionsController do
  render_views

  def configure_valid_omniauth_login
    OmniAuthSpecHelper.valid_saml_login_setup('email@example.com', '1234')

    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:saml]
  end

  def configure_valid_loa3_omniauth_login
    OmniAuthSpecHelper.valid_saml_loa3_login_setup('email@example.com',
                                                   '12345',
                                                   'Harvey',
                                                   'Snorfax',
                                                   '987654322')

    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:saml]
  end

  describe 'POST /auth/saml/callback' do
    context 'when the authorization is valid' do
      it 'signs the user in and redirects to dashboard with flash notice' do
        configure_valid_omniauth_login
        post :create, provider: :saml

        expect(session[:user_id]).to eq User.last.id
        expect(response).to redirect_to success_url
        expect(flash[:notice]).to eq I18n.t('omniauth_callbacks.success')
      end
    end

    context 'when the authorization is LOA3' do
      before do
        @user1 =  User.new(
          provider: 'test_provider',
          uid: nil,
          email: 'user1@example.com',
          first_name: 'William',
          last_name: 'Tell',
          phone: '2021234561',
          social_security_number: '987654321'
        )

        if @user1.save
          puts 'save success'
        else
          puts 'save fail'
        end

        @user2 =  User.new(
          provider: 'test_provider',
          uid: nil,
          email: 'user2@example.com',
          first_name: 'Harvey',
          last_name: 'Snorfax',
          phone: '2021234562',
          social_security_number: '987654322'
        )

        @user2.save!

        @user3 =  User.new(
          provider: 'test_provider',
          uid: '1234',
          email: 'user3@example.com',
          first_name: 'William',
          last_name: 'Orange',
          phone: '2021234563',
          social_security_number: '987654323'
        )
        @user3.save!
      end

      it 'finds a user with no uid' do
        configure_valid_loa3_omniauth_login
        post :create, provider: :saml

        expect(session[:user_id]).to eq @user2.id
      end

      it 'finds a user with uid' do
        configure_valid_omniauth_login
        post :create, provider: :saml

        expect(session[:user_id]).to eq @user3.id
      end
    end
  end
end
