class Image < ActiveRecord::Base
  belongs_to :gallery
  has_many :comments, dependent: :destroy

  has_many :likes, as: :likable, dependent: :destroy

  has_many :group_images, dependent: :destroy
  has_many :groups, through: :group_images

  validates :name, presence: true
  validates :description, presence: true
  validates :url, presence: true

  has_many :activities, as: :subject, dependent: :destroy

  def user
    gallery.user
  end

end
