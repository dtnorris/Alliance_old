class CreateCharacterClasses < ActiveRecord::Migration
  def change
    create_table :character_classes do |t|
      t.string :name
      t.integer :build_per_body
      t.integer :armor_limit

      t.timestamps
    end
    add_column :characters, :character_class_id, :integer
  end
end
