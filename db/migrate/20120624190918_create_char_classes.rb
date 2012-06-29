class CreateCharClasses < ActiveRecord::Migration
  def change
    create_table :char_classes do |t|
      t.string :name
      t.integer :build_per_body
      t.integer :armor_limit

      t.timestamps
    end
  end
end
