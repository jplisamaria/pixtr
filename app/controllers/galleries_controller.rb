class GalleriesController < ApplicationController
  respond_to :html
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
      notify_followers(@gallery, @gallery, "CreateGalleryActivity")
      redirect_to @gallery
    else
      render :new #this requires instance variables
    end
  end

  def show
    @gallery = Gallery.find(params[:id])
    @images = @gallery.images.includes(gallery: [:user])
  end
 
  def edit
    @gallery = find_gallery
  end

  def update
    @gallery = find_gallery
    @gallery.update(gallery_params)
    respond_with @gallery
  end

  def destroy
    gallery = find_gallery
    gallery.destroy
    redirect_to root_path
  end

  private

  def gallery_params
    params.require(:gallery).permit(:name)
  end

  def find_gallery
    current_user.galleries.find(params[:id])
  end
end
