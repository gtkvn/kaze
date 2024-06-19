class PasswordController < ApplicationController
  skip_ensure_email_is_verified

  def update
    form = UpdatePasswordForm.new(params.permit(:current_password, :password, :password_confirmation))

    return redirect_to profile_edit_path, inertia: { errors: form.error_messages } if form.invalid?

    Current.auth.user.update(password: form.password)

    redirect_back_or_to profile_edit_path
  end
end
