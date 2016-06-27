Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :saml,
    assertion_consumer_service_url: 'http://localhost:3003/auth/saml/callback',
    assertion_consumer_service_binding: 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST',
    issuer: Rails.application.secrets.saml_issuer,
    idp_sso_target_url: Rails.application.secrets.idp_url,
    idp_cert_fingerprint: '8B:D5:C2:E8:9A:2B:CE:B7:4B:95:50:BA:16:79:05:27:17:D1:D3:67',
    name_identifier_format: 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
    authn_context: 'http://idmanagement.gov/ns/assurance/loa/1',
    allowed_clock_drift: 60,
    certificate: File.read("#{Rails.root}/certs/sp/demo_sp.crt"),
    private_key: File.read("#{Rails.root}/keys/saml_test_sp.key"),
    security: { authn_requests_signed: true,
                embed_sign: true,
                digest_method: 'http://www.w3.org/2001/04/xmlenc#sha256',
                signature_method: 'http://www.w3.org/2001/04/xmldsig-more#rsa-sha256' }
  )
end

OmniAuth.config.on_failure = proc do |env|
  SessionsController.action(:failure).call(env)
end
