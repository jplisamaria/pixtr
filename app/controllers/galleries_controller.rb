class GalleriesController < ApplicationController
  before_action :authorize, except: [:show] 
    # except show because you want other users to see it.
    # also before_filter

  def index
    @galleries = current_user.galleries
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = current_user.galleries.new(gallery_params)
    if @gallery.save
      current_user.notify_followers(@gallery, "CreateGalleryActivity")
      redirect_to @gallery
    else
      render :new #this requires instance variables
    end
  end

  def show
    @gallery = Gallery.find(params[:id])
    @images = @gallery.images
  end
 
  def edit
    @gallery = current_user.galleries.find(params[:id])
  end

  def update
    @gallery = current_user.galleries.find(params[:id])
    if @gallery.update(gallery_params)
      #binding.pry
      redirect_to @gallery
    else
      render :edit
    end
  end

  def destroy
    gallery = current_user.galleries.find(params[:id])
    gallery.destroy
    redirect_to root_path
  end

  private

  def gallery_params
    params.require(:gallery).permit(:name)
  end
end
