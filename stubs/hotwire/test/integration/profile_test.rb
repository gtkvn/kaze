require 'test_helper'

class ProfileTest < ActionDispatch::IntegrationTest
  test 'profile page is displayed' do
    user = FactoryBot.create :user

    acting_as(user).get profile_edit_path

    assert_response :success
  end

  test 'profile information can be updated' do
    user = FactoryBot.create :user

    acting_as(user).patch profile_edit_path, params: {
      name: 'Test User',
      email: 'test@example.com'
    }

    assert_redirected_to profile_edit_path

    user.reload

    assert_equal 'Test User', user.name
    assert_equal 'test@example.com', user.email
  end

  test 'user can delete their account' do
    user = FactoryBot.create :user

    acting_as(user).delete profile_destroy_path, params: {
      password: 'password'
    }

    assert_redirected_to '/'

    assert_guest
    assert_raise(ActiveRecord::RecordNotFound) { user.reload }
  end

  test 'correct password must be provided to delete account' do
    user = FactoryBot.create :user

    acting_as(user).delete profile_destroy_path, params: {
      password: 'wrong-password'
    }

    assert_response :unprocessable_entity
    assert_not_nil user.reload
  end
end
