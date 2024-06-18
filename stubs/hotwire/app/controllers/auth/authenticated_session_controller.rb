class Auth::AuthenticatedSessionController < ApplicationController
  include RedirectIfAuthenticated

  skip_authenticate only: %i[new create]
  skip_redirect_if_authenticated only: :destroy
  skip_ensure_email_is_verified only: :destroy

  layout 'guest'

  def new
    @form = Auth::LoginForm.new

    render 'auth/login'
  end

  def create
    @form = Auth::LoginForm.new(params.permit(:email, :password, :remember))

    @form.authenticate

    return render 'auth/login', status: :unprocessable_entity if Current.auth.user.nil?

    redirect_to dashboard_path
  end

  def destroy
    Current.auth.logout

    reset_session

    redirect_to '/'
  end
end
