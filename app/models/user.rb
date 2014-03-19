class User < ActiveRecord::Base
  include Clearance::User

  has_many :galleries
  has_many :images, through: :galleries

  has_many :group_memberships, foreign_key: :member_id #use foreign_key if id is not class name
  has_many :groups, through: :group_memberships
end
