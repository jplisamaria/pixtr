class GroupMembership < ActiveRecord::Base
  belongs_to :member, class_name: "User"
  belongs_to :group

  validates :member_id, uniqueness: { scope: :group_id }

  has_many :activities, as: :subject, dependent: :destroy

  # validate :cannot_follow_yourself   
  # validate for custonm methods, 
  # but validates for predefined methods

  # private

  #def cannot_follow_yourself
  #  if followed_user_id == follower_id
  #    errors.add( :base, "You may not follow yourself." )
  #  end
  #end

end