class AddFieldsToEntries < ActiveRecord::Migration[5.0]
  def change
    change_table :main_entries do |t|
      t.remove :group

      t.text :provenience
      t.text :historic_evidence
      t.text :literature
      t.text :description
      t.text :appreciation

      t.change :location, :integer
    end

    change_table :sub_entries do |t|
      t.string :material
      t.string :creator
      t.string :location
      t.string :dating
      t.string :markings
      t.string :height
      t.string :width
      t.string :depth
      t.string :diameter
      t.string :weight
      t.string :height_with_socket
      t.string :width_with_socket
      t.string :depth_with_socket
      t.text :framing
      t.text :restaurations
    end
  end
end
