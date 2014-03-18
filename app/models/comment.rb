class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :image

  validates :body, presence: true #comes from ActiveRecord
  validates :user, presence: true

  def self.recent  #class method, or scope
    order(created_at: :desc)
  end

  #or scope :recent, -> { order(created_at:desc)}
  #always want to return ActiveMethod relation i.e. acts like an array
end
