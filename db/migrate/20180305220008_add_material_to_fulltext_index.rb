class AddMaterialToFulltextIndex < ActiveRecord::Migration[5.0]
  def up
    execute "DROP INDEX se_terms ON sub_entries"
    execute "CREATE FULLTEXT INDEX se_terms ON sub_entries (title, description, markings, restaurations, material)"

    change_table :sub_entries do |t|
      t.string :material_reverse
    end
  end

  def down
    execute "DROP INDEX se_terms ON sub_entries"
    execute "CREATE FULLTEXT INDEX se_terms ON sub_entries (title, description, markings, restaurations)"

    change_table :sub_entries do |t|
      t.remove :material_reverse
    end
  end
end
