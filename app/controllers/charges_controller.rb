class ChargesController < ApplicationController
  def create
    charge = Charge.new(current_user, params[:stripeToken])
    charge.process
    redirect_to account_path
  end
end