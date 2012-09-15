class AddCharacterIdToMembers < ActiveRecord::Migration
  def change
    add_column :members, :character_id, :integer, :default => false
  end
end
