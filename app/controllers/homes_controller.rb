class HomesController < ApplicationController
  before_action :goto_dashboard, if: :signed_in? 
              #make it the symbol :signed_in?
              #and not the method.
  def show
  end

  private
  def goto_dashboard
      redirect_to dashboard_path
  end
end
