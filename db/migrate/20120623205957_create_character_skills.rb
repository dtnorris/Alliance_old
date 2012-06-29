class CreateCharacterSkills < ActiveRecord::Migration
  def change
    create_table :character_skills do |t|
      t.timestamps
      t.integer :character_id
      t.integer :skill_id
      t.boolean :bought
      t.integer :amount
    end
  end
end
