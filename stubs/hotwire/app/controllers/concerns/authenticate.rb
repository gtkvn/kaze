module Authenticate
  extend ActiveSupport::Concern

  included do
    before_action :authenticate!
  end

  class_methods do
    def skip_authenticate(**options)
      skip_before_action :authenticate!, **options
    end
  end

  private

  def authenticate!
    redirect_to login_path unless Current.auth.check?
  end
end
