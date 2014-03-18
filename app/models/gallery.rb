class Gallery < ActiveRecord::Base
  belongs_to :user
  has_many :images

  validates :name, presence: true
  validates :user, presence: true  ##important to use user and not user_id
end
