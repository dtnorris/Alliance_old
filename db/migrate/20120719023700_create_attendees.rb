class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.integer :character_id
      t.integer :event_id
      t.boolean :applied,     :default => false
      t.boolean :pc

      t.timestamps
    end
  end
end
