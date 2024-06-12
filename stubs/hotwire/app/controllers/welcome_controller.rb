class WelcomeController < ApplicationController
  skip_authentication

  def index
    render layout: nil
  end
end
