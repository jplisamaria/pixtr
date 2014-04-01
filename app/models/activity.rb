class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject, polymorphic: true
  belongs_to :actor, class_name: "User" 
  belongs_to :target, polymorphic: true

  def self.recent #class method because it's a 
                  #collection of objects.
    order(created_at: :desc)
  end
end
