class AddFulltextIndices < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE FULLTEXT INDEX me_terms ON main_entries (title, provenience, historical_evidence, literature, description, appreciation)"
    execute "CREATE FULLTEXT INDEX se_terms ON sub_entries (title, description, markings, restaurations)"
  end

  def down
    execute "DROP INDEX me_terms ON main_entries"
    execute "DROP INDEX se_terms ON sub_entries"
  end
end
