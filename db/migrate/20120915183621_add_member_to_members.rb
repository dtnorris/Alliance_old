class AddMemberToMembers < ActiveRecord::Migration
  def change
    add_column :members, :member, :boolean, :default => false
  end
end
