class AddReverseIndexFields < ActiveRecord::Migration[5.0]
  def up
    change_table :main_entries do |t|
      t.string :title_reverse
      t.text :provenience_reverse
      t.text :historical_evidence_reverse
      t.text :literature_reverse
      t.text :description_reverse
      t.text :appreciation_reverse
    end

    change_table :sub_entries do |t|
      t.string :title_reverse
      t.text :description_reverse
      t.text :markings_reverse
      t.text :restaurations_reverse
    end

    MainEntry.all.each do |me|
      fields = [
        :title, :provenience, :historical_evidence, :literature, :description,
        :appreciation
      ]

      fields.each do |f|
        if me[f].present?
          me.update_column "#{f}_reverse".to_sym, me[f].reverse
        end
      end
    end

    SubEntry.all.each do |se|
      [:title, :description, :markings, :restaurations].each do |f|
        if se[f].present?
          se.update_column "#{f}_reverse".to_sym, se[f].reverse
        end
      end
    end

    execute "CREATE FULLTEXT INDEX me_terms_reverse ON main_entries (title_reverse, provenience_reverse, historical_evidence_reverse, literature_reverse, description_reverse, appreciation_reverse)"
    execute "CREATE FULLTEXT INDEX se_terms_reverse ON sub_entries (title_reverse, description_reverse, markings_reverse, restaurations_reverse)"
  end
  
  def down
    execute "DROP INDEX me_terms_reverse ON main_entries"
    execute "DROP INDEX se_terms_reverse ON sub_entries"

    change_table :main_entries do |t|
      t.remove :title_reverse
      t.remove :provenience_reverse
      t.remove :historical_evidence_reverse
      t.remove :literature_reverse
      t.remove :description_reverse
      t.remove :appreciation_reverse
    end

    change_table :sub_entries do |t|
      t.remove :title_reverse
      t.remove :description_reverse
      t.remove :markings_reverse
      t.remove :restaurations_reverse
    end
  end
end
