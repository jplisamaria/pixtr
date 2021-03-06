class DashboardsController < ApplicationController 
  def show
    @activities = current_user.
      activities.
      recent.
      includes(:actor, :target)
  end
end