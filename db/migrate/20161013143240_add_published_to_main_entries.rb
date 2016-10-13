class AddPublishedToMainEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :main_entries, :publish, :boolean, default: true
  end
end
