class Group < ActiveRecord::Base
  ##join table
  has_many :group_memberships, dependent: :destroy
  has_many :members, through: :group_memberships

  ##another join table
  has_many :group_images, dependent: :destroy
  has_many :images, through: :group_images

  validates :name, presence: true

  def self.search(search = nil)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end
end