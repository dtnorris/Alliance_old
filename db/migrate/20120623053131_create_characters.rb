class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :user_id
      t.integer :chapter_id
      t.integer :race_id
      t.integer :char_class_id
      t.integer :experience_points
      t.integer :build_points
      t.integer :spent_build
      t.integer :body_points

      t.timestamps
    end
  end
end
