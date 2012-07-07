class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :chapter_id
      t.integer :user_id
      t.integer :goblin_stamps

      t.timestamps
    end
  end
end
