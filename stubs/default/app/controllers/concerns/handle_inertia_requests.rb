module HandleInertiaRequests
  extend ActiveSupport::Concern

  included do
    inertia_share do
      { auth: { user: Current.user } }
    end
  end
end
