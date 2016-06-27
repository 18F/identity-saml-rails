require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'from_omniauth' do
    describe 'for a user that already exists' do
      before do
        @user = User.new(
          provider: 'test_provider',
          uid: 'test_uid',
          email: 'email@example.com'
        )

        @user.save!
      end

      it 'finds a user if they exist and leaves the email, name alone' do
        auth = OmniAuth::AuthHash.new(provider: 'test_provider',
                                      uid: 'test_uid',
                                      info: {
                                        email: 'new_email@example.com',
                                        name: 'Name McNameface'
                                      })
        user = nil
        expect { user = User.from_omniauth(auth) }.to change { User.all.count }.by(0)
        expect(user.email).to eq(@user.email)
        expect(user.name).to eq(@user.name)
      end
    end

    describe 'for a new user' do
      it 'creates a user if they do not exist' do
        auth = OmniAuth::AuthHash.new(provider: 'test_provider',
                                      uid: 'test_uid',
                                      info: {
                                        email: 'new_email@example.com',
                                        name: 'Name McNameface'
                                      })
        user = nil
        expect { user = User.from_omniauth(auth) }.to change { User.all.count }.by(1)
        expect(user.email).to eq(auth.info.email)
        expect(user.name).to eq(auth.info.name)
      end
    end
  end
end
