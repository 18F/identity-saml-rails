require 'rails_helper'
require 'omniauth_spec_helper'

describe Users::OmniauthCallbacksController, devise: true do
  render_views

  def configure_valid_omniauth_login
    OmniAuthSpecHelper.valid_saml_login_setup('email@example.com', '1234')

    configure_request_env
  end

  def configure_invalid_omniauth_email
    OmniAuthSpecHelper.valid_saml_login_setup('invalid_email', '1234')

    configure_request_env
  end

  def configure_request_env
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:saml]
  end

  describe 'GET /users/auth/saml/callback' do
    context 'when the authorization is valid' do
      before do
        configure_valid_omniauth_login
        get :saml
      end

      it 'signs the user in and redirects to dashboard' do
        expect(controller.user_signed_in?).to eq true
        expect(response).to redirect_to('/')
      end

      it 'displays a success notice' do
        expect(flash[:notice]).
          to eq 'Successfully authenticated from IdP account.'
      end
    end

    context 'when the authorization is invalid' do
      before do
        configure_invalid_omniauth_email
        get :saml
      end

      it 'does not sign the user in and redirects to login page' do
        expect(controller.signed_in?).to eq false
        expect(response).to redirect_to('/users/sign_up')
      end

      it 'displays an error alert' do
        expect(flash[:error]).
          to eq 'Sorry, we could not authenticate you. Please try again later.'
      end
    end
  end
end
