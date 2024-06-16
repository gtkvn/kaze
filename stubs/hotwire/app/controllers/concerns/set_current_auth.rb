module SetCurrentAuth
  extend ActiveSupport::Concern

  included do
    before_action do
      Current.auth = SessionGuard.new(name: 'web', session: session, cookies: cookies)
    end
  end
end
