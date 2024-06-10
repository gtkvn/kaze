class DashboardController < ApplicationController
  def show
    render inertia: "Dashboard"
  end
end
