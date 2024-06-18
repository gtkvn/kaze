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

      acting_as(user).get verification_url(id: user.id, hash: Digest::SHA1.hexdigest(user.email))

      assert user.reload.has_verified_email?
      assert_redirected_to dashboard_path(verified: '1')
    end

    test 'email is not verified with invalid hash' do
      user = FactoryBot.create(:user, :unverified)

      acting_as(user).get verification_url(id: user.id, hash: Digest::SHA1.hexdigest('wrong-email'))

      assert_not user.reload.has_verified_email?
    end
  end

  private

  def verification_url(params)
    verifier = ActiveSupport::MessageVerifier.new(ENV.fetch('RAILS_MASTER_KEY', ''))

    signature = verifier.generate(verification_verify_url(params), expires_in: 60.minutes.from_now.to_i)

    verification_verify_url(params.merge(signature: signature))
  end
end
