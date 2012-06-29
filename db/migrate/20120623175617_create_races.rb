class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.string :name
      t.integer :body_mod

      t.timestamps
    end
  end
end
