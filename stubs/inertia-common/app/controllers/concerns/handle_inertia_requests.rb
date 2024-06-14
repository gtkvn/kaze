module HandleInertiaRequests
  extend ActiveSupport::Concern

  included do
    inertia_share do
      { auth: { user: Current.auth.get_user } }
    end
  end
end
