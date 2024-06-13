class Auth::AuthenticatedSessionController < ApplicationController
  skip_authentication only: %i[new create]

  layout 'guest'

  def new
    @form = Auth::LoginForm.new

    render 'auth/login'
  end

  def create
    @form = Auth::LoginForm.new params.permit(:email, :password)

    user = @form.authenticate

    return render 'auth/login', status: :unprocessable_entity if user.nil?

    login user

    redirect_to dashboard_path
  end

  def destroy
    logout

    redirect_to login_path
  end
end
