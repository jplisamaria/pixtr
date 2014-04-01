class GroupMembershipsController < ApplicationController

  def create
    @group = Group.find(params[:id])
    current_user.join @group
    render :change
#    redirect_to group

  end

  def destroy
    @group = Group.find(params[:id])
    current_user.leave @group
    render :change
#    redirect_to group
  end
end