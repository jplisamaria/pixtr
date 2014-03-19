class Group < ActiveRecord::Base
  ##join table
  has_many :group_memberships
  has_many :members, through: :group_memberships

  ##another join table
  has_many :group_images
  has_many :images, through: :group_images

  validates :name, presence: true

end