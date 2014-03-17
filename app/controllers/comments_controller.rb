class CommentsController < ApplicationController

  def create
    image = Image.find(params[:image_id])
    image.comments.create(comment_params)
    #binding.pry
    redirect_to image
  end

  def comment_params
    params.
      require(:comment).
      permit(:body).
      merge(user_id: current_user.id)
  end
end
