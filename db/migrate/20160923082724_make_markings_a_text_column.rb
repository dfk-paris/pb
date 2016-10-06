class MakeMarkingsATextColumn < ActiveRecord::Migration[5.0]
  def change
    change_column :sub_entries, :markings, :text
  end
end
