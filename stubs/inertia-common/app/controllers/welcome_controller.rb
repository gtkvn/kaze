class WelcomeController < ApplicationController
  skip_authenticate

  def index
    render inertia: 'Welcome', props: {
      railsVersion: Rails.version,
      rubyVersion: RUBY_DESCRIPTION
    }
  end
end
