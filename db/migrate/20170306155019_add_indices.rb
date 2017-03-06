class AddIndices < ActiveRecord::Migration[5.0]
  def change
    add_index :main_entries, [:title, :location], name: 'searchy'
    add_index :sub_entries, [:main_entry_id, :title, :location, :creator], name: 'searchy'
  end
end
