class User < ActiveRecord::Base
  include Clearance::User

  has_many :activities

  has_many :galleries, dependent: :destroy
  has_many :images, through: :galleries

  has_many :group_memberships, 
    dependent: :destroy,
    foreign_key: :member_id #use foreign_key if id is not class name
  has_many :groups, 
    through: :group_memberships

  has_many :followed_user_relationships, 
    foreign_key: :follower_id, dependent: :destroy,
    class_name: "FollowingRelationship"
  has_many :followed_users, 
    through: :followed_user_relationships

  has_many :follower_relationships, 
    foreign_key: :followed_user_id, 
    dependent: :destroy,
    class_name: "FollowingRelationship"  
  has_many :followers, 
    through: :follower_relationships  

  has_many :likes, dependent: :destroy, inverse_of: :user
  has_many :liked_images, 
    through: :likes, 
    source: :likable,
    source_type: 'Image'

  has_many :liked_galleries, 
    through: :likes,
    source: :likable,
    source_type:' Gallery'


  def follow(other_user)
    follow_someone = followed_user_relationships.create(
      followed_user: other_user)
  end

  def unfollow(other_user)
    followed_users.destroy(other_user)
  end

  def following?(other_user) 
    followed_user_ids.include?(other_user.id)
  end

  def join(joined_group)
    join_group = group_memberships.create(group: joined_group)
  end

  def leave(group)
    groups.destroy(group)
  end

  def member?(group)
    group_ids.include?(group.id)
  end

  def like(target)
    like = likes.create(likable: target)
  end

  def likes?(target)
    likes.exists?(likable: target)
  end

  def unlike(target)
    likes.find_by(likable: target).destroy
  end

  def premium?
    stripe_id.present?
  end  
end
