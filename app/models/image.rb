class Image < ActiveRecord::Base
  belongs_to :gallery
  has_many :comments, dependent: :destroy

  has_many :likes, as: :likable, dependent: :destroy

  has_many :group_images, dependent: :destroy
  has_many :groups, through: :group_images

  validates :name, presence: true
  validates :url, presence: true

  has_many :activities, as: :subject, dependent: :destroy

  acts_as_taggable

  def user
    gallery.user
  end

  # def self.search(search_params)
  #   query = search_params[:query]
  #   image_ids = self.tagged_with(query).pluck(:id)
  #   where("name ILIKE :query OR description ILIKE :query OR id IN (:image_ids)", query: "%#{query}%", image_ids: image_ids)
  # end
end
