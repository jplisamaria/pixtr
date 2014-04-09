class SearchesController < ApplicationController
  def show
    @query = params[:search][:query]
    @images = find_images
  end

  private
  def find_images
    image_searcher = ImageSearcher.new(params[:search])
    image_searcher.get_images.includes(gallery: [:user])
  end
end
