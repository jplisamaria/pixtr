class Gallery < ActiveRecord::Base
  belongs_to :user
  has_many :images, dependent: :destroy

  has_many :activities, as: :subject, dependent: :destroy

  validates :name, presence: true
  validates :user, presence: true  ##important to use user and not user_id
end
