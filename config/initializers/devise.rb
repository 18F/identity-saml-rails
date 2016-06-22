# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 11

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

  config.omniauth :saml,
                  :assertion_consumer_service_url     => "http://localhost:3003/users/auth/saml/callback",
                  :assertion_consumer_service_binding => "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST",
                  :issuer                             => Rails.application.secrets.saml_issuer,
                  :idp_sso_target_url                 => Rails.application.secrets.idp_url,
                  :idp_cert                           => File.read("#{Rails.root}/certs/saml.crt"),
                  :name_identifier_format             => "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress",
                  :authn_context                      => "http://idmanagement.gov/ns/assurance/loa/1",
                  :allowed_clock_drift                => 60,
                  :certificate                        => File.read("#{Rails.root}/certs/sp/demo_sp.crt"),
                  :private_key                        => File.read("#{Rails.root}/keys/saml_test_sp.key"),
                  :security                           => {:authn_requests_signed => true,
                                                          :embed_sign            => true,
                                                          :digest_method         => "http://www.w3.org/2001/04/xmlenc#sha256",
                                                          :signature_method      => "http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"}
end
