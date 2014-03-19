class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :description
      t.timestamps
    end
    create_table :group_memberships do |t|
      t.belongs_to :member, index: true
      t.belongs_to :group, index: true
      t.timestamps
    end
    # or add_index :group_memberships, :group_id
    #and add_index :group_memberships, :user_id
    # instead of index: true

  end
end
