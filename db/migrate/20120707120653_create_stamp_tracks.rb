class CreateStampTracks < ActiveRecord::Migration
  def change
    create_table :stamp_tracks do |t|
      t.integer :user_id
      t.integer :chapter_id
      t.integer :start_stamps
      t.integer :end_stamps
      t.string :reason
      t.boolean :dragon

      t.timestamps
    end
  end
end
