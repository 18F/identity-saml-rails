require 'rails_helper'
require 'omniauth_spec_helper'

describe 'POST /auth/saml/callback' do
  context 'invalid credentials' do
    it 'redirects to root with flash error' do
      OmniAuthSpecHelper.invalid_credentials

      OmniAuthSpecHelper.silence_omniauth do
        post '/auth/saml/callback'
      end

      expect(response).to redirect_to root_url
      expect(flash[:error]).
        to eq I18n.t('omniauth_callbacks.failure', reason: 'Invalid credentials')
    end
  end

  context 'invalid ticket' do
    it 'redirects to root with flash error' do
      OmniAuthSpecHelper.invalid_ticket

      OmniAuthSpecHelper.silence_omniauth do
        post '/auth/saml/callback'
      end

      expect(response).to redirect_to root_url
      expect(flash[:error]).
        to eq I18n.t('omniauth_callbacks.failure', reason: 'Invalid ticket')
    end
  end
end
