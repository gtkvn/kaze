class WelcomeController < ApplicationController
  skip_authentication

  def index
    render inertia: "Welcome", props: {
      railsVersion: Rails.version,
      rubyVersion: RUBY_DESCRIPTION
    }
  end
end
