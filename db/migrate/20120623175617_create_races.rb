class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.string :name

      t.timestamps
    end
    add_column :characters, :race_id, :integer
    remove_column :characters, :race
  end
end
