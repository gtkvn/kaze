class Auth::NewPasswordController < ApplicationController
  include RedirectIfAuthenticated

  skip_authenticate

  def new
    render inertia: 'Auth/ResetPassword', props: {
      token: params[:token]
    }
  end

  def create
    form = Auth::NewPasswordForm.new params.permit(:token, :password, :password_confirmation)

    return redirect_to login_path, flash: { status: 'Your password has been reset.' } if form.reset?

    redirect_back_or_to password_reset_path(token: form.token),
                        inertia: { errors: form.error_messages }
  end
end
