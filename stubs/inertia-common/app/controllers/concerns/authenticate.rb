module Authenticate
  extend ActiveSupport::Concern

  included do
    before_action :authenticate!
    before_action :ensure_email_is_verified! if User.include?(MustVerifyEmail)
  end

  class_methods do
    def skip_authenticate(**options)
      skip_before_action :authenticate!, **options
      skip_ensure_email_is_verified(**options)
    end

    def skip_ensure_email_is_verified(**options)
      skip_before_action :ensure_email_is_verified!, **options if User.include?(MustVerifyEmail)
    end
  end

  private

  def authenticate!
    redirect_to login_path unless Current.auth.check?
  end

  def ensure_email_is_verified!
    redirect_to verification_notice_path unless Current.auth.user && Current.auth.user.has_verified_email?
  end
end
