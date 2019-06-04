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

  describe 'POST auth/saml/setup' do
    context 'when using IAL1 authentication' do
      it 'sets assurance level to LOA1' do
        request.env['omniauth.strategy'] = instance_double('Strategy', :options => { saml: [] })
        post :setup, params: { provider: :saml, ial: '1' }

        authn_context = request.env['omniauth.strategy'].options[:authn_context]
        expected_result = [
          "http://idmanagement.gov/ns/assurance/loa/1",
          "http://idmanagement.gov/ns/requested_attributes?ReqAttr=email,phone,first_name,last_name,ssn"
        ]
        expect(authn_context).to eq(expected_result)
      end
    end

    context 'when using IAL2 authentication' do
      it 'sets assurance level to LOA3' do
        request.env['omniauth.strategy'] = instance_double('Strategy', :options => { saml: [] })
        post :setup, params: { provider: :saml, ial: '2' }

        authn_context = request.env['omniauth.strategy'].options[:authn_context]
        expected_result = [
          "http://idmanagement.gov/ns/assurance/loa/3",
          "http://idmanagement.gov/ns/requested_attributes?ReqAttr=email,phone,first_name,last_name,ssn"
        ]
        expect(authn_context).to eq(expected_result)
      end
    end

    context 'when IAL has not been selected' do
      it 'sets assurance level to LOA1' do
        request.env['omniauth.strategy'] = instance_double('Strategy', :options => { saml: [] })
        post :setup, params: { provider: :saml, ial: nil }

        authn_context = request.env['omniauth.strategy'].options[:authn_context]
        expected_result = [
          "http://idmanagement.gov/ns/assurance/loa/1",
          "http://idmanagement.gov/ns/requested_attributes?ReqAttr=email,phone,first_name,last_name,ssn"
        ]
        expect(authn_context).to eq(expected_result)
      end
    end
  end
end
