class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :race_id
      t.integer :char_class_id
      t.integer :experience_points
      t.integer :build_points
      t.integer :spent_build
      t.integer :new_skill
      t.integer :buy_skill

      t.timestamps
    end
  end
end
