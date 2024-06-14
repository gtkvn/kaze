require "test_helper"

class Auth::AuthenticationTest < ActionDispatch::IntegrationTest
  test "login screen can be rendered" do
    get login_path

    assert_response :success
  end

  test "users can authenticate using the login screen" do
    user = FactoryBot.create :user

    post login_path, params: {
      email: user.email,
      password: "password",
    }

    assert_authenticated
    assert_redirected_to dashboard_path
  end

  test "users cannot authenticate with invalid password" do
    user = FactoryBot.create :user

    post login_path, params: {
      email: user.email,
      password: "wrong-password",
    }

    assert_guest
  end

  test "users can logout" do
    user = FactoryBot.create :user

    acting_as user

    post logout_path

    assert_guest
    assert_redirected_to "/"
  end
end
