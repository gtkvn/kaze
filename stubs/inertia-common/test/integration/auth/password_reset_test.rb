require 'test_helper'

class Auth::PasswordResetTest < ActionDispatch::IntegrationTest
  test 'reset password link screen can be rendered' do
    get password_request_path

    assert_response :success
  end

  test 'reset password link can be requested' do
    user = FactoryBot.create :user
    token = user.generate_token_for(:password_reset)
    email = UserMailer.with(user: user, token: token).reset_password

    post password_email_path, params: { email: user.email }

    assert_enqueued_email_with UserMailer, :reset_password, params: { user: user, token: token } do
      email.deliver_later
    end
  end

  test 'reset password screen can be rendered' do
    user = FactoryBot.create :user

    get password_reset_path(token: user.generate_token_for(:password_reset))

    assert_response :success
  end

  test 'password can be reset_with_valid_token' do
    user = FactoryBot.create :user

    post password_store_path, params: {
      token: user.generate_token_for(:password_reset),
      password: 'password',
      password_confirmation: 'password'
    }

    assert_redirected_to login_path
  end
end
