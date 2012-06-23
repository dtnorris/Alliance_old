class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.integer :fighter_cost
      t.integer :scout_cost
      t.integer :rogue_cost
      t.integer :adept_cost
      t.integer :scholar_cost
      t.integer :templar_cost
      t.integer :artisan_cost

      t.timestamps
    end
  end
end
