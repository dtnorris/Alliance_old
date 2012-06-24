class CreateCharClasses < ActiveRecord::Migration
  def change
    create_table :char_classes do |t|
      t.string :name
      t.integer :build_per_body
      t.integer :armor_limit

      t.timestamps
    end
    add_column :characters, :char_class_id, :integer
  end
end
