module VerifyCsrfToken
  extend ActiveSupport::Concern

  included do
    before_action :set_csrf_cookie

    rescue_from ActionController::InvalidAuthenticityToken do
      redirect_back fallback_location: "/", notice: "The page expired, please try again."
    end
  end

  def request_authenticity_tokens
    super << request.headers["HTTP_X_XSRF_TOKEN"]
  end

  private

  def set_csrf_cookie
    cookies["XSRF-TOKEN"] = {
      value: form_authenticity_token,
      same_site: "Strict"
    }
  end
end
