class AddFulltextIndices < ActiveRecord::Migration[5.0]
  def up
    remove_index :sub_entries, [:main_entry_id, :title, :location, :creator]
    add_index :sub_entries, [:main_entry_id, :title, :location, :creator],
      name: 'searchy',
      length: {title: 100, location: 50, creator: 50}

    execute "ALTER TABLE sub_entries ENGINE=MyISAM"
    execute "ALTER TABLE main_entries ENGINE=MyISAM"

    execute "CREATE FULLTEXT INDEX me_terms ON main_entries (title, provenience, historical_evidence, literature, description, appreciation)"
    execute "CREATE FULLTEXT INDEX se_terms ON sub_entries (title, description, markings, restaurations)"
  end

  def down
    execute "DROP INDEX me_terms ON main_entries"
    execute "DROP INDEX se_terms ON sub_entries"
    
    execute "ALTER TABLE main_entries ENGINE=InnoDB"
    execute "ALTER TABLE sub_entries ENGINE=InnoDB"

    remove_index :sub_entries, [:main_entry_id, :title, :location, :creator]
    add_index :sub_entries, [:main_entry_id, :title, :location, :creator], name: 'searchy'
  end
end
