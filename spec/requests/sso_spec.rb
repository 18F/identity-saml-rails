require 'rails_helper'

describe 'SSO' do
  before do
    OmniAuth.config.test_mode = false
  end

  context 'IAL1' do
    it 'uses external SAML IdP' do
      expect(User.count).to eq 0

      get '/auth/saml'
      expect(response).to redirect_to(%r{idp\.example\.com\/api\/saml\/auth})

      idp_uri = URI(response.headers['Location'])
      saml_idp_resp = Net::HTTP.get(idp_uri)

      saml_response = OneLogin::RubySaml::Response.new(saml_idp_resp)
      asserted_attributes = saml_response.attributes.attributes.keys.map(&:to_sym)
      expect(asserted_attributes).to match_array(%i[uid email])

      post '/auth/saml/callback', params: { SAMLResponse: saml_idp_resp }

      expect(response).to redirect_to('http://www.example.com/success')
      expect(User.count).to eq 1
    end
  end

  context 'IAL2' do
    it 'returns asserted attributes' do
      expect(User.count).to eq 0

      get '/auth/saml?ial=2'
      expect(response).to redirect_to(%r{idp\.example\.com\/api\/saml\/auth})

      idp_uri = URI(response.headers['Location'])
      saml_idp_resp = Net::HTTP.get(idp_uri)

      saml_response = OneLogin::RubySaml::Response.new(saml_idp_resp)
      asserted_attributes = saml_response.attributes.attributes.keys.map(&:to_sym)
      expect(asserted_attributes).to match_array(
        %i[uid email phone first_name last_name ssn]
      )

      post '/auth/saml/callback', params: { SAMLResponse: saml_idp_resp }

      expect(response).to redirect_to('http://www.example.com/success')
      expect(User.count).to eq 1
    end
  end
end
