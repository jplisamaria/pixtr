class SearchesController < ApplicationController
  def show
    @query = params[:search][:query]
    @images = find_images
  end

  private
  def find_images
    image_searcher = ImageSearcher.new(params[:search])
    image_searcher.search_for_tags.includes(gallery: [:user])
  end
end
