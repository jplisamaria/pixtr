class GalleryLikesController < ApplicationController
  def create
    @gallery = Gallery.find(params[:id])
    current_user.like @gallery
#    redirect_to gallery
    render :change
  end

  def destroy
    @gallery = Gallery.find(params[:id])
    current_user.unlike @gallery
#    redirect_to gallery
    render :change
  end
end