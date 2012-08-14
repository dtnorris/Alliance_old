class CreateDeaths < ActiveRecord::Migration
  def change
    create_table :deaths do |t|
      t.integer :character_id
      t.integer :chapter_id
      t.boolean :regen_css,     :default => false
      t.boolean :buyback,       :default => false

      t.timestamps
    end
  end
end
