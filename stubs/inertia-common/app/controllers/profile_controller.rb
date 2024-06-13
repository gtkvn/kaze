class ProfileController < ApplicationController
  def edit
    render inertia: 'Profile/Edit', props: {
      status: session[:status]
    }
  end

  def update
    form = UpdateProfileInformationForm.new params.permit(:name, :email)

    return redirect_to profile_edit_path, inertia: { errors: form.error_messages } if form.invalid?

    Current.user.update(name: form.name, email: form.email)

    redirect_to profile_edit_path
  end

  def destroy
    form = DeleteUserForm.new params.permit(:password)

    return redirect_back_or_to profile_edit_path, inertia: { errors: form.error_messages } if form.invalid?

    user = Current.user

    logout

    user.delete

    redirect_to '/'
  end
end
