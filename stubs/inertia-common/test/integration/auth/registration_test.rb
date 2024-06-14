require 'test_helper'

class Auth::RegistrationTest < ActionDispatch::IntegrationTest
  test 'registration screen can be rendered' do
    get register_path

    assert_response :success
  end

  test 'new users can register' do
    post register_path, params: {
      name: 'Test User',
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    assert_authenticated
    assert_redirected_to dashboard_url
  end
end
