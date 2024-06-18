class Auth::RegisteredUserController < ApplicationController
  include RedirectIfAuthenticated

  skip_authenticate

  layout 'guest'

  def new
    @form = Auth::RegisterForm.new

    render 'auth/register'
  end

  def create
    @form = Auth::RegisterForm.new params.permit(:name, :email, :password, :password_confirmation)

    return render 'auth/register', status: :unprocessable_entity if @form.invalid?

    user = User.create(name: @form.name, email: @form.email, password: @form.password)

    if User.include?(MustVerifyEmail) && !user.has_verified_email?
      user.send_email_verification_notification
    end

    Current.auth.login(user)

    redirect_to dashboard_path
  end
end
