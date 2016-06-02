Rails.application.config.middleware.use OmniAuth::Builder do
  provider :saml,
           :assertion_consumer_service_url     => "http://localhost:3003/users/auth/saml/callback",
           :assertion_consumer_service_binding => "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST",
           :issuer                             => Rails.configuration.x.saml_issuer,
           :idp_sso_target_url                 => Rails.configuration.x.idp_url,
           :idp_cert                           => File.read('config/demo_sp.crt'),
           :name_identifier_format             => "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress",
           :authn_context                      => "http://idmanagement.gov/ns/assurance/loa/1",
           :allowed_clock_drift                => 60,
           :certificate                        => File.read('config/demo_sp.crt'),
           :private_key                        => File.read('config/demo_sp.key'),
           :security                           => {:authn_requests_signed => true,
                                                   :embed_sign            => true,
                                                   :digest_method         => "http://www.w3.org/2001/04/xmlenc#sha256",
                                                   :signature_method      => "http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"}
end
