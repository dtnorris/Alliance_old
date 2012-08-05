class AddCharacterIdToMembers < ActiveRecord::Migration
  def change
    add_column :members, :character_id, :integer
  end
end
