class CreateCharacterSkills < ActiveRecord::Migration
  def change
    create_table :character_skills do |t|
      t.timestamps
      t.integer :character_id
      t.integer :skill_id
      t.boolean :bought
      t.integer :amount
    end
    remove_column :characters, :character_skill_id, :integer
    add_column :characters, :new_skill, :string
    add_column :skills, :skill_type, :string
  end
end
