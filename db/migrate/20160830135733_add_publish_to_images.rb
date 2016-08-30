class AddPublishToImages < ActiveRecord::Migration[5.0]
  def change
    add_column :media, :publish, :boolean
    add_column :sub_entries, :no_title, :boolean
  end
end
