module RedirectIfAuthenticated
  extend ActiveSupport::Concern

  included do
    before_action :redirect_if_authenticated!
  end

  class_methods do
    def skip_redirect_if_authenticated(**options)
      skip_before_action :redirect_if_authenticated!, **options
    end
  end

  private

  def redirect_if_authenticated!
    redirect_to dashboard_path if Current.auth.check?
  end
end
