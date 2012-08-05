class AddBlanketListToMembers < ActiveRecord::Migration
  def change
    add_column :members, :blanket_list, :boolean
  end
end
