class Auth::PasswordResetLinkController < ApplicationController
  skip_authentication

  def new
    render inertia: 'Auth/ForgotPassword', props: {
      status: flash[:status]
    }
  end

  def create
    form = Auth::SendPasswordResetLinkForm.new params.permit(:email)

    return redirect_back_or_to password_request_path, inertia: { errors: form.error_messages } unless form.send_reset_link?

    redirect_back_or_to password_request_path, flash: { status: 'We have emailed your password reset link.' }
  end
end
