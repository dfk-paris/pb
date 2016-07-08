class Init < ActiveRecord::Migration[5.0]
  def up
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password
      t.timestamps
    end

    create_table :main_entries do |t|
      t.string :title
      t.string :location
      t.string :group
      t.string :sequence
      t.timestamps
    end

    create_table :sub_entries do |t|
      t.belongs_to :main_entry
      t.string :title
      t.string :sequence
      t.text :description
      t.timestamps
    end

    create_table :media do |t|
      t.belongs_to :sub_entry
      t.string :caption
      t.has_attached_file :image
      t.timestamps
    end
  end

  def down
    drop_table :users
    drop_table :main_entries
    drop_table :sub_entries
    drop_table :media
  end
end
