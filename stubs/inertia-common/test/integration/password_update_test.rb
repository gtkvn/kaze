require "test_helper"

class PasswordUpdateTest < ActionDispatch::IntegrationTest
  test "password can be updated" do
    user = FactoryBot.create :user

    acting_as(user).put password_update_path, params: {
      :current_password => 'password',
      :password => 'new-password',
      :password_confirmation => 'new-password',
    }

    assert_redirected_to profile_edit_path
    assert BCrypt::Password.new(user.reload.password_digest).is_password?('new-password')
  end

  test 'correct password must be provided to update password' do
    user = FactoryBot.create :user

    acting_as(user).put password_update_path, params: {
      :current_password => 'wrong-password',
      :password => 'new-password',
      :password_confirmation => 'new-password',
    }

    assert_redirected_to profile_edit_path
  end
end
