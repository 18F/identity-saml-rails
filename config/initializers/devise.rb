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

  # puts Rails.application.config.middleware.class
  # saml_config = Saml::Config.new
  config.omniauth :saml,
                  :assertion_consumer_service_url     => "http://localhost:3003/users/auth/saml/callback",
                  :assertion_consumer_service_binding => "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST",
                  :issuer                             => Rails.configuration.x.saml_issuer,
                  :idp_sso_target_url                 => Rails.configuration.x.idp_url,
                  # :idp_cert                           => "-----BEGIN CERTIFICATE-----
# MIIFcDCCA1gCCQCLxDQyL6Rq/jANBgkqhkiG9w0BAQsFADB6MQswCQYDVQQGEwJV
# UzELMAkGA1UECBMCREMxEzARBgNVBAcTCldhc2hpbmd0b24xDDAKBgNVBAoTAzE4
# RjE7MDkGA1UEAxMyZWMyLTU0LTE4My0yMTYtMTY5LnVzLXdlc3QtMS5jb21wdXRl
# LmFtYXpvbmF3cy5jb20wHhcNMTQwOTE5MDcwNDE1WhcNMTYwOTE4MDcwNDE1WjB6
# MQswCQYDVQQGEwJVUzELMAkGA1UECBMCREMxEzARBgNVBAcTCldhc2hpbmd0b24x
# DDAKBgNVBAoTAzE4RjE7MDkGA1UEAxMyZWMyLTU0LTE4My0yMTYtMTY5LnVzLXdl
# c3QtMS5jb21wdXRlLmFtYXpvbmF3cy5jb20wggIiMA0GCSqGSIb3DQEBAQUAA4IC
# DwAwggIKAoICAQDMYOFxoaejHqunlhVCXIq4afydSLeraw7yZaWaDid1DyPAFh0B
# D7fl7AyIDuYycTf2MeN9XtqnIOJvh5a/WI0hR4rnCCZoDsXRBACdrl+v7gMQbgfS
# yU0nMGMzy9hgdjv1bKshy4HImPvkepbh+bfsQUcVey7d7fPofZbKFvglPuhl9m3R
# TWPOttxs4KqU48jkVpo3xvrJtY1TpYdDti1DEGtXrIWiokqSeByeYjfWE0t8jucf
# 5kAjTqhCBwfelGkjiPogFRdNQyA14Yhp7Ri/EPHGWUZWuuuHdBiJXOvAM3fzafNF
# PVpCdB91RmcRMzZp6NQxGt2BvOiq6pw1RSjDLvTJlsb6XH/fCnOqoLejwhTpM7nW
# CW8tBuN1iU48TNNP1B12QNm35Uwx2TJc7y/NiPBukWVgn0JfeO6u567/WELxfUh3
# 0RmtTLwujEkpma8VEQre2c8b62mQV0sahcepY7kvRd18fWWozA2tUlxMO7k+54g+
# pHxWc5eYG6B7KHbDytTakFcRSXJXB7MJHantSH0PH9XcKQdszjAjJRxOGzwe627i
# AZrhA48tsT31qEH2J0jMGdQTurWsbAW37SBl/qqoki+v5Iq5QUvVAt9Dfhk63C2z
# lcGmjRTEi+BPgTAdWPLfJt5JXzb7j6iTjWYGAqHs5nYzGXoKvrTia0gFlwIDAQAB
# MA0GCSqGSIb3DQEBCwUAA4ICAQAucIhQLj2Rj5LTrfRkd4S8tcekaN6BYaNF49Eo
# JofFfdKoe1bl+fhgnYXDXvJpqZZ/acChNT4uNNS0+OxWyyoYHAmBn8sDdJJI/5Hw
# OpYyKSVcxGWq4EYijCyFxtYGbIUu7L79G1fIKeDG4Fd9jTyteHPkPzQZlxhT+hky
# jVuXN3YVQRepJdwrZ2TgrCxpMsKtL2XyAK+TncWj08eWIL7eyDxAzlb3z4nwhFW4
# SjhKXG9nLn/8VsZcCJ1VwxqRNj9wxuuN4uq/PgY7uDkxIKXL8LLvCILnvyWEn9sG
# NLk3n3kb9XjVxteyb4+46OMUmlI9muQy9rA7uXhal/pDwF/E+OFBo+XNXZFOnQCy
# 8fRtVLfgPTl5vc87Rv3LMUAq6pTHceYQsWnqFsJW3nyBotGKA5dixOU8rvZ5UXGD
# 3yjK+BCWmNtDbMPyNNnbOTR8i1F3PPlNtKLhUlqWSfQnemTJgwrT++g8QhxqHi4d
# OtcWfsX5H/JXBu4xf5MQcK0hUJc8lF+VDC8MiqKGeqpItDp/O0RkVLZyQ+h3Bj07
# R7W2gxnLGVycYx+aiH3hH5PZxepVjLoczE05I5EHwoyF/q4izMgWAp4qUA7E8No1
# GDgvklHR9Ej05xDscs3/RW5wfka+6fSFn1AEJUISzjK4pUt9hhsP8VfcI9nYl5bI
# 9QhHBA==
# -----END CERTIFICATE-----",
                  # :idp_cert                           => File.read("#{Rails.root}/config/saml_cert.crt"),
                  :idp_cert_fingerprint               => 'E6:12:DC:4D:93:66:02:E0:74:AE:B8:2C:F8:2C:3A:C5:AA:20:3D:60',
                  :name_identifier_format             => "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress",
                  :authn_context                      => "http://idmanagement.gov/ns/assurance/loa/1",
                  :allowed_clock_drift                => 60,
                  :certificate                        => File.read('config/demo_sp.crt'),
                  :private_key                        => File.read('config/demo_sp.key'),
                  :security                           => {:authn_requests_signed => true,
                                                          :embed_sign            => true,
                                                          :digest_method         => "http://www.w3.org/2001/04/xmlenc#sha256",
                                                          :signature_method      => "http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"}
#                 idp_cert: saml_config.settings[:idp_cert],
  #                 idp_sso_target_url: saml_config.settings[:idp_sso_target_url]
  # config.omniauth :saml
end
