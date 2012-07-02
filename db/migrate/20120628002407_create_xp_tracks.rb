class CreateXpTracks < ActiveRecord::Migration
  def change
    create_table :xp_tracks do |t|
      t.integer :character_id
      t.integer :start_xp
      t.integer :end_xp
      t.integer :start_build
      t.integer :end_build
      t.string :reason

      t.timestamps
    end
  end
end
