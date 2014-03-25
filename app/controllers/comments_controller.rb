class CommentsController < ApplicationController

  def create
    image = Image.find(params[:image_id])
    comment = image.comments.new(comment_params)
    if comment.save
    
      current_user.notify_followers(comment, "CommentActivity")
      redirect_to image, notice: "Comment added."
    else
      redirect_to image, alert: "Comment cannot be blank."
    end
  end

  private
  def comment_params
    params.
      require(:comment).
      permit(:body).
      merge(user_id: current_user.id)
  end
end
