class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :build_points
      t.integer :experience_points
      t.string :buy_skill

      t.timestamps
    end
  end
end
