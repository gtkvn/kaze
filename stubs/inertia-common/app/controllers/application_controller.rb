class ApplicationController < ActionController::Base
  include SetCurrentAuth
  include Authenticate
  include HandleInertiaRequests
  include VerifyCsrfToken
end
