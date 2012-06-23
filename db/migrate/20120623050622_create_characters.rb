class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.name
      t.build_points
      t.experience_points
      t.timestamps
    end
  end
end
