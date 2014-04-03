class GroupsController < ApplicationController

  before_action :authorize, except: [:show]

  def index
    if params.has_key?(:search)
      @groups = Group.search(params[:search])
    else
      @groups = current_user.groups
    end
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      current_user.join(@group)
      redirect_to @group
    else
      render :new 
    end
  end

  def show
    @group = Group.find(params[:id])
    @images = @group.images.includes(gallery: [:user])
  end

  private
  def group_params
    params.require(:group).permit(:name, :description)
  end
end