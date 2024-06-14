class WelcomeController < ApplicationController
  skip_authenticate

  def index
    render layout: nil
  end
end
