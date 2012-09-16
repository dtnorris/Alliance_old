class AddNotesToMembers < ActiveRecord::Migration
  def change
    add_column :members, :notes, :string, :default => "Click here to set member notes"
  end
end
