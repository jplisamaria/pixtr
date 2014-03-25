class Like < ActiveRecord::Base
  belongs_to :image
  belongs_to :user

  has_many :activities, as: :subject, dependent: :destroy

  validates :user, presence: true, uniqueness: { scope: :image }
  validates :image, presence: true
end
