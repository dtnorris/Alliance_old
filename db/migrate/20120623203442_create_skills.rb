class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.integer :fighter
      t.integer :scout
      t.integer :rogue
      t.integer :adept
      t.integer :scholar
      t.integer :templar
      t.integer :artisan

      t.timestamps
    end
  end
end
