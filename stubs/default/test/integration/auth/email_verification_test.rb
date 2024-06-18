require 'test_helper'

class EmailVerificationTest < ActionDispatch::IntegrationTest
  if User.include?(MustVerifyEmail)
    test 'email verification screen can be rendered' do
      user = FactoryBot.create(:user, :unverified)

      acting_as(user).get verification_notice_path

      assert_response :success
    end

    test 'email can be verified' do
      user = FactoryBot.create(:user, :unverified)

      acting_as(user).get verification_verify_path(id: user.id, hash: Digest::SHA1.hexdigest(user.email))

      assert user.reload.has_verified_email?
      assert_redirected_to dashboard_path(verified: '1')
    end

    test 'email is not verified with invalid hash' do
      user = FactoryBot.create(:user, :unverified)

      acting_as(user).get verification_verify_path(id: user.id, hash: Digest::SHA1.hexdigest('wrong-email'))

      assert_not user.reload.has_verified_email?
    end
  end
end
