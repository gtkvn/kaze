class PasswordController < ApplicationController
  skip_ensure_email_is_verified

  def update
    @update_password_form = UpdatePasswordForm.new(params.permit(:current_password, :password, :password_confirmation))

    return render partial: 'profile/partials/update_password_form', status: :unprocessable_entity if @update_password_form.invalid?

    Current.auth.user.update(password: @update_password_form.password)

    redirect_back_or_to profile_edit_path, flash: { status: 'password-updated' }
  end
end
