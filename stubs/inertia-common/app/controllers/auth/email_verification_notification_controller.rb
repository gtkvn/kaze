class Auth::EmailVerificationNotificationController < ApplicationController
  skip_ensure_email_is_verified

  before_action { redirect_to dashboard_path unless User.include?(MustVerifyEmail) }

  def new
    return redirect_to dashboard_path if Current.auth.user.has_verified_email?

    render inertia: 'Auth/VerifyEmail', props: {
      status: flash[:status]
    }
  end

  def create
    return redirect_to dashboard_path if Current.auth.user.has_verified_email?

    Current.auth.user.send_email_verification_notification

    redirect_back_or_to dashboard_path, flash: { status: 'verification-link-sent' }
  end
end
