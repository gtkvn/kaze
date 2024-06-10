class ApplicationController < ActionController::Base
  include Authenticate
  include HandleInertiaRequests
  include VerifyCsrfToken
end
