require 'rails_helper'
require 'omniauth_spec_helper'

describe SessionsController do
  render_views

  def configure_valid_omniauth_login
    OmniAuthSpecHelper.valid_saml_login_setup('email@example.com', '1234')

    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:saml]
  end

  describe 'POST /auth/saml/callback' do
    context 'when the authorization is valid' do
      it 'signs the user in and redirects to dashboard with flash notice' do
        configure_valid_omniauth_login
        post :create, params: { provider: :saml }

        expect(session[:user_id]).to eq User.last.id
        expect(response).to redirect_to success_url
        expect(flash[:notice]).to eq I18n.t('omniauth_callbacks.success')
      end
    end
  end
end
