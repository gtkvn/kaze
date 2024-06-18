class Auth::PasswordResetLinkController < ApplicationController
  include RedirectIfAuthenticated

  skip_authenticate

  layout 'guest'

  def new
    @form = Auth::SendPasswordResetLinkForm.new

    render 'auth/forgot_password'
  end

  def create
    @form = Auth::SendPasswordResetLinkForm.new(params.permit(:email))

    return redirect_back_or_to password_request_path, flash: { status: 'We have emailed your password reset link.' } if @form.send_reset_link?

    render 'auth/forgot_password', status: :unprocessable_entity
  end
end
