class Auth::VerifiedEmailController < ApplicationController
  include ValidateSignature

  skip_ensure_email_is_verified

  before_action { redirect_to dashboard_path unless User.include?(MustVerifyEmail) }

  def create
    return redirect_to dashboard_path(verified: '1') if Current.auth.user.has_verified_email?

    Current.auth.user.mark_email_as_verified if email_verification_request_is_authorized?

    redirect_to dashboard_path(verified: '1')
  end

  private

  def email_verification_request_is_authorized?
    return false if !ActiveSupport::SecurityUtils.secure_compare Current.auth.user.id.to_s, params[:id]

    ActiveSupport::SecurityUtils.secure_compare Digest::SHA1.hexdigest(Current.auth.user.email), params[:hash]
  end
end
