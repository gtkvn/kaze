class DashboardController < ApplicationController
  def index
    render inertia: 'Dashboard'
  end
end
