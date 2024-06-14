class ApplicationController < ActionController::Base
  include SetCurrentAuth
  include Authenticate
end
