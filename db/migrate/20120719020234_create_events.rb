class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :chapter_id
      t.integer :xp_value
      t.date :date
      t.string :name
      t.boolean :applied

      t.timestamps
    end
  end
end
