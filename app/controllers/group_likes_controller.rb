class GroupLikesController < ApplicationController

  def create
    @group = find_group
    current_user.like @group
#    redirect_to group
  end

  def destroy
    @group = find_group
    current_user.unlike @group
#    redirect_to group
  end  

  private
  def find_group
    Group.find(params[:id])
  end
end