class Auth::AuthenticatedSessionController < ApplicationController
  skip_authentication only: %i[new create]

  def new
    render inertia: 'Auth/Login', props: {
      canResetPassword: true,
      status: flash[:status]
    }
  end

  def create
    form = Auth::LoginForm.new params.permit(:email, :password)

    user = form.authenticate

    return redirect_back_or_to login_path, inertia: { errors: form.error_messages } if user.nil?

    login user

    redirect_to dashboard_path
  end

  def destroy
    logout

    redirect_to login_path
  end
end
