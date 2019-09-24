class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    current_user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.assign_from_auth(auth)
    end
    current_user.sync_auth_email(auth.info.email)
    current_user
  end

  def assign_from_auth(auth)
    self.uid = auth.uid

    assign_attrs(auth.info)
    extra_attributes_from_auth(auth) if auth.extra
  end

  def sync_auth_email(email)
    update(email: email) unless self.email == email
  end

  private

  def assign_attrs(auth_attrs)
    self.email = auth_attrs.email
    self.first_name = auth_attrs.first_name
    self.middle_name = auth_attrs.middle_name
    self.last_name = auth_attrs.last_name
  end

  def extra_attributes_from_auth(auth)
    extra_attrs = auth.extra.raw_info
    self.social_security_number = extra_attrs[:ssn]
    self.phone = extra_attrs[:phone]
  end
end
