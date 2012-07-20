class CreatePatronXps < ActiveRecord::Migration
  def change
    create_table :patron_xps do |t|
      t.integer :character_id
      t.integer :event_id
      t.boolean :applied
      t.boolean :pc

      t.timestamps
    end
  end
end
