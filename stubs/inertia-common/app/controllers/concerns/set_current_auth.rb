module SetCurrentAuth
  extend ActiveSupport::Concern

  included do
    before_action do
      Current.auth = Auth.new('web', session)
    end
  end
end
