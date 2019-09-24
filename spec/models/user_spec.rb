require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'from_omniauth' do
    describe 'for a user that already exists' do
      before do
        @user = User.new(
          provider: 'test_provider',
          uid: 'test_uid',
          email: 'email@example.com',
          first_name: 'William',
          last_name: 'Tell',
          phone: '2021234567',
          social_security_number: '987654321'
        )

        @user.save!
      end

      context 'when the found user has the same email as the one from omniauth' do
        it 'finds the user and leaves the user info alone' do
          auth = OmniAuth::AuthHash.new(provider: 'test_provider',
                                        uid: 'test_uid',
                                        info: {
                                          email: 'email@example.com',
                                          first_name: 'Name',
                                          last_name: 'McNameface'
                                        },
                                        extra: {
                                          raw_info: {
                                            ssn: '123456789',
                                            phone: '4155551212'
                                          }
                                        })
          user = nil
          expect { user = User.from_omniauth(auth) }.to change { User.all.count }.by(0)
          expect(user.email).to eq(@user.email)
          expect(user.first_name).to eq(@user.first_name)
          expect(user.last_name).to eq(@user.last_name)
          expect(user.phone).to eq(@user.phone)
          expect(user.social_security_number).to eq(@user.social_security_number)
        end
      end

      context 'when the found user has a different email as the one from omniauth' do
        it 'finds the user and updates the email' do
          auth = OmniAuth::AuthHash.new(provider: 'test_provider',
                                        uid: 'test_uid',
                                        info: {
                                          email: 'a_different_email@example.com',
                                          first_name: 'Name',
                                          last_name: 'McNameface'
                                        },
                                        extra: {
                                          raw_info: {
                                            ssn: '123456789',
                                            phone: '4155551212'
                                          }
                                        })
          user = nil
          expect { user = User.from_omniauth(auth) }.to change { User.all.count }.by(0)
          expect(user.email).to eq(auth.info.email)
          expect(user.first_name).to eq(@user.first_name)
          expect(user.last_name).to eq(@user.last_name)
          expect(user.phone).to eq(@user.phone)
          expect(user.social_security_number).to eq(@user.social_security_number)
        end
      end
    end

    describe 'for a new user' do
      it 'creates a user if they do not exist' do
        auth = OmniAuth::AuthHash.new(provider: 'test_provider',
                                      uid: 'test_uid',
                                      info: {
                                        email: 'new_email@example.com',
                                        first_name: 'Name',
                                        last_name: 'McNameface'
                                      },
                                      extra: {
                                        raw_info: {
                                          ssn: '123456789',
                                          phone: '4155551212'
                                        }
                                      })
        user = nil
        expect { user = User.from_omniauth(auth) }.to change { User.all.count }.by(1)
        expect(user.email).to eq(auth.info.email)
        expect(user.first_name).to eq(auth.info.first_name)
        expect(user.last_name).to eq(auth.info.last_name)
        expect(user.phone).to eq(auth.extra.raw_info.phone)
        expect(user.social_security_number).to eq(auth.extra.raw_info.ssn)
      end
    end
  end
end
