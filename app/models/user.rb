class User < ActiveRecord::Base
  include Clearance::User

  has_many :galleries
  has_many :images, through: :galleries

  has_many :group_memberships, 
    foreign_key: :member_id #use foreign_key if id is not class name
  has_many :groups, 
    through: :group_memberships

  has_many :followed_user_relationships, 
    foreign_key: :follower_id,
    class_name: "FollowingRelationship"
  has_many :followed_users, 
    through: :followed_user_relationships

  has_many :follower_relationships, 
    foreign_key: :followed_user_id,
    class_name: "FollowingRelationship"  
  has_many :follower_relationships, 
    through: :follower_relationships

  def follow(other_user)
    followed_users << other_user
  end

  def unfollow(other_user)
    followed_users.destroy(other_user)
  end

  def following?(other_user) 
    followed_user_ids.include?(other_user.id)
  end

end
