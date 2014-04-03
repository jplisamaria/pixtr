class User < ActiveRecord::Base
  include Clearance::User

  has_many :activities

  has_many :galleries, dependent: :destroy
  has_many :images, through: :galleries

  has_many :group_memberships, dependent: :destroy,
    foreign_key: :member_id #use foreign_key if id is not class name
  has_many :groups, 
    through: :group_memberships

  has_many :followed_user_relationships, 
    foreign_key: :follower_id, dependent: :destroy,
    class_name: "FollowingRelationship"
  has_many :followed_users, 
    through: :followed_user_relationships

  has_many :follower_relationships, 
    foreign_key: :followed_user_id, dependent: :destroy,
    class_name: "FollowingRelationship"  
  has_many :followers, 
    through: :follower_relationships  

  has_many :likes, dependent: :destroy
  has_many :liked_images, 
    through: :likes, 
    source: :likable,
    source_type: 'Image'
  has_many :liked_galleries, 
    through: :likes,
    source: :likable,
    source_type: 'Gallery'


  def follow(other_user)
#    followed_users << other_user
    follow_someone = followed_user_relationships.create(
      followed_user: other_user)
    notify_followers(follow_someone, other_user, "FollowSomeoneActivity")
  end

  def unfollow(other_user)
    followed_users.destroy(other_user)
  end

  def following?(other_user) 
    followed_user_ids.include?(other_user.id)
  end

  def join(joined_group)
    # groups << group #doesn't return group membership.
    # => [<#Group>, <#Group>, <#Group> ] 
    join_group = group_memberships.create(group: joined_group)
    notify_followers(join_group, joined_group, "JoinGroupActivity")
  end

  def notify_followers(subject, target, type)
    followers.each do |follower|
      follower.activities.create(
        actor: self,
        subject: subject,
        type: type,
        target: target
      )
    end
  end
  handle_asynchronously :notify_followers

  def leave(group)
    groups.destroy(group)
  end

  def member?(group)
    group_ids.include?(group.id)
  end

  def like(target)
    like = likes.create(likable: target)
    notify_followers(like, target, "LikeActivity")
  end

  def likes?(target)
    likes.exists?(likable: target)
  end

  def unlike(target)
    likes.find_by(likable: target).destroy
  end

  def premium?
    stripe_id.length > 0
  end  
end
