module ValidateSignature
  extend ActiveSupport::Concern

  included do
    before_action do
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found unless has_valid_signature?
    end
  end

  private

  def has_valid_signature?
    request.original_url.split('?')[0] == ActiveSupport::MessageVerifier.new(ENV.fetch('RAILS_MASTER_KEY', '')).verify(params[:signature])
  rescue
    false
  end
end
