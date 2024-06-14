class Auth::NewPasswordController < ApplicationController
  include RedirectIfAuthenticated

  skip_authenticate

  layout 'guest'

  def new
    @form = Auth::NewPasswordForm.new params.permit(:token)

    render 'auth/reset_password'
  end

  def create
    @form = Auth::NewPasswordForm.new params.permit(:token, :password, :password_confirmation)

    return redirect_to login_path, flash: { status: 'Your password has been reset.' } if @form.reset?

    render 'auth/reset_password', status: :unprocessable_entity
  end
end
