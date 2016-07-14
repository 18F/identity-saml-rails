class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.assign_from_auth(auth)
    end
  end

  def assign_from_auth(auth)
    auth_attrs = auth.info
    self.email = auth_attrs.email
    self.name = auth_attrs.name
    self.uid = auth.uid
  end
end
