module OmniAuthSpecHelper
  def self.valid_saml_login_setup(email_address, uuid)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
      :saml,
      provider: 'saml',
      uid: uuid,
      info: {
        email: email_address,
        uuid: uuid
      },
      extra: {
        raw_info: {
          email: email_address,
          uuid: uuid
        }
      }
    )
  end
end
