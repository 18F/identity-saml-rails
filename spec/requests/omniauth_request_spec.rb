require 'rails_helper'
require 'omniauth_spec_helper'

describe 'POST /auth/saml/callback' do
  context 'invalid credentials' do
    it 'redirects to failure with flash error' do
      OmniAuthSpecHelper.invalid_credentials

      OmniAuthSpecHelper.silence_omniauth do
        post '/auth/saml/callback'
      end

      expect(response).to redirect_to failure_url
      expect(flash[:alert]).
        to eq I18n.t('omniauth_callbacks.failure', reason: 'Invalid credentials')
    end
  end

  context 'invalid ticket' do
    it 'redirects to failure with flash error' do
      OmniAuthSpecHelper.invalid_ticket

      OmniAuthSpecHelper.silence_omniauth do
        post '/auth/saml/callback'
      end

      expect(response).to redirect_to failure_url
      expect(flash[:alert]).
        to eq I18n.t('omniauth_callbacks.failure', reason: 'Invalid ticket')
    end
  end
end
