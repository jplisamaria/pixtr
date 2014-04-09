class CommentsController < ApplicationController

  def create
    image = Image.find(params[:image_id])
    @comment = image.comments.new(comment_params)#.include(:user)
    if @comment.save
      notify_followers(@comment, image, "CommentActivity")
    end
  end

  def destroy
    image = Image.find(params[:image_id]) #add current_user.comments lkj;lkj;lkj
    @comment = image.comments.find(params[:id]).destroy
  end


  private
  def comment_params
    params.
      require(:comment).
      permit(:body).
      merge(user_id: current_user.id)
  end
end
