class ImagesController < ApplicationController
  def index
    if params[:tag]
      @images = Image.tagged_with(params[:tag]).includes(gallery: [:user])
      @tag = params[:tag]
    else
      @images = Image.all
    end
  end

  def new
    @gallery = current_user.galleries.find(params[:gallery_id])
    @image = Image.new
  end

  def create
    @gallery = current_user.galleries.find(params[:gallery_id])
    @image = @gallery.images.new(image_params)
    if @image.save
      current_user.notify_followers(@image, @image, "CreateImageActivity")
      redirect_to @gallery
    else
      render :new ##renders a new view.  Change variables to instance variables.
                  ## is ok the first time because new sets @gallery and @image.
    end
  end

  def show
    @image = Image.find(params[:id])
    @comment = Comment.new
    @comments = @image.comments.recent.page(params[:page]).
      per(2).includes(:user, :image) #class method

  end

  def edit
    @image = current_user.images.find(params[:id])
    @groups = current_user.groups #grabs list of groups for use in 
                                  #the checkboxes implementation
  end

  def update
    @image = current_user.images.find(params[:id])
    if @image.update(image_params)
      redirect_to @image
    else
      @groups = current_user.groups
      render :edit
    end
  end


  def destroy
    image = current_user.images.find(params[:id])
    image.destroy
    redirect_to image.gallery
  end

  private

  def image_params
    params.require(:image).permit(
      :name,
      :url,
      :description,
      :tag_list,
      group_ids: [] #special syntax for accepting an array
    )
  end
end
