require 'rails_helper'

describe 'SSO' do
  before do
    OmniAuth.config.test_mode = false
  end

  context 'LOA1' do
    it 'uses external SAML IdP' do
      expect(User.count).to eq 0

      get '/auth/saml'
      expect(response).to redirect_to(%r{idp\.example\.com\/saml\/auth})

      idp_uri = URI(response.headers['Location'])
      saml_idp_resp = Net::HTTP.get(idp_uri)

      saml_response = OneLogin::RubySaml::Response.new(saml_idp_resp)
      asserted_attributes = saml_response.attributes.attributes.keys.map(&:to_sym)
      expect(asserted_attributes).to match_array([:uid, :email])

      post '/auth/saml/callback', SAMLResponse: saml_idp_resp

      expect(response).to redirect_to('http://www.example.com/success')
      expect(User.count).to eq 1
    end
  end

  context 'LOA3' do
    it 'returns asserted attributes' do
      expect(User.count).to eq 0

      get '/auth/saml?loa=3'
      expect(response).to redirect_to(%r{idp\.example\.com\/saml\/auth})

      idp_uri = URI(response.headers['Location'])
      saml_idp_resp = Net::HTTP.get(idp_uri)

      saml_response = OneLogin::RubySaml::Response.new(saml_idp_resp)
      asserted_attributes = saml_response.attributes.attributes.keys.map(&:to_sym)
      expect(asserted_attributes).to match_array(
        [:uid, :email, :phone, :first_name, :last_name, :ssn]
      )

      post '/auth/saml/callback', SAMLResponse: saml_idp_resp

      expect(response).to redirect_to('http://www.example.com/success')
      expect(User.count).to eq 1
    end
  end
end
