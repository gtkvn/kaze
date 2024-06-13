class Auth::RegisteredUserController < ApplicationController
  skip_authentication

  def new
    render inertia: 'Auth/Register'
  end

  def create
    form = Auth::RegisterForm.new params.permit(:name, :email, :password, :password_confirmation)

    return redirect_to register_path, inertia: { errors: form.error_messages } if form.invalid?

    user = User.create(name: form.name, email: form.email, password: form.password)

    login user

    redirect_to dashboard_path
  end
end
