class AddSequenceToMedia < ActiveRecord::Migration[5.0]
  def change
    add_column :media, :sequence, :string
  end
end
