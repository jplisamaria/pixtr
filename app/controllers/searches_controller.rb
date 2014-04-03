class SearchesController < ApplicationController
  def show
    @query = params[:search][:query]
    @images = Image.search(params[:search]).includes(gallery: [:user])
  end
end
