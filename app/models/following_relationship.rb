class FollowingRelationship < ActiveRecord::Base
  belongs_to :followed_user, class_name: "User" 
  belongs_to :follower, class_name: "User"

  validates :follower_id, uniqueness: { scope: :followed_user_id }

  validate :cannot_follow_yourself   ##validate for custonm methods, but validates for predefined methods

  private

  def cannot_follow_yourself
    if followed_user_id == follower_id
      errors.add( :base, "You may not follow yourself." )
    end
  end
end
