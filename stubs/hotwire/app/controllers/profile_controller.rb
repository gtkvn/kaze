class ProfileController < ApplicationController
  skip_ensure_email_is_verified

  def edit
    @update_profile_information_form = UpdateProfileInformationForm.new(name: Current.auth.user.name, email: Current.auth.user.email)
    @update_password_form = UpdatePasswordForm.new
    @delete_user_form = DeleteUserForm.new

    render 'profile/edit'
  end

  def update
    @update_profile_information_form = UpdateProfileInformationForm.new(params.permit(:name, :email))

    return render partial: 'profile/partials/update_profile_information_form', status: :unprocessable_entity if @update_profile_information_form.invalid?

    @update_profile_information_form.update

    redirect_to profile_edit_path, flash: { status: 'profile-updated' }
  end

  def destroy
    @delete_user_form = DeleteUserForm.new(params.permit(:password))

    return render partial: 'profile/partials/delete_user_form', status: :unprocessable_entity if @delete_user_form.invalid?

    user = Current.auth.user

    Current.auth.logout

    user.delete

    reset_session

    redirect_to '/'
  end
end
