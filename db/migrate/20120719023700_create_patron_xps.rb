class CreatePatronXps < ActiveRecord::Migration
  def change
    create_table :patron_xps do |t|
      t.integer :character_id
      t.integer :event_id
      t.integer :user_id
      t.boolean :applied

      t.timestamps
    end
  end
end
