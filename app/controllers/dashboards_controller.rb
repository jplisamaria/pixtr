class DashboardsController < ApplicationController 
  def show
    @activities = current_user.activities.recent.includes(:subject, :actor, :target)
  end
end