class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :owner
      t.string :email
      t.string :name
      t.string :location

      t.timestamps
    end
  end
end
