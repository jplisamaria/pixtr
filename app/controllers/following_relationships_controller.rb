class FollowingRelationshipsController < ApplicationController

  def create
    @followed_user = find_user
    following_relationship = current_user.follow @followed_user
    notify_followers(following_relationship, @followed_user, "FollowSomeoneActivity")
    @user = @followed_user
  end

  def destroy
    @followed_user = find_user
    current_user.unfollow @followed_user
    @user = @followed_user
  end

private
  def find_user
    User.find(params[:id])
  end

end
