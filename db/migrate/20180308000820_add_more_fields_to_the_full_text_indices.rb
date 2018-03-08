class AddMoreFieldsToTheFullTextIndices < ActiveRecord::Migration[5.0]
  def up
    old_fields = [
      'title',
      'description',
      'markings',
      'restaurations',
      'material'
    ]
    new_fields = [
      'creator',
      'dating',
      'height',
      'width',
      'depth',
      'diameter',
      'weight',
      'height_with_socket',
      'width_with_socket',
      'depth_with_socket',
      'framing'
    ]
    fields = (old_fields + new_fields).join(', ')
    execute "DROP INDEX se_terms ON sub_entries"
    execute "CREATE FULLTEXT INDEX se_terms ON sub_entries (#{fields})"

    change_table :sub_entries do |t|
      t.string :creator_reverse
      t.string :dating_reverse
      t.string :height_reverse
      t.string :width_reverse
      t.string :depth_reverse
      t.string :diameter_reverse
      t.string :weight_reverse
      t.string :height_with_socket_reverse
      t.string :width_with_socket_reverse
      t.string :depth_with_socket_reverse
      t.text :framing_reverse
    end

    execute "DROP INDEX se_terms_reverse ON sub_entries"
    fields = (old_fields + new_fields).map{|f| "#{f}_reverse"}.join(', ')
    execute "CREATE FULLTEXT INDEX se_terms_reverse ON sub_entries (#{(old_fields + new_fields).join(', ')})"

    SubEntry.all.each do |se|
      fields = [
        :title, :description, :markings, :restaurations, :material,
        :creator, :dating, :height, :width, :depth, :diameter, :weight,
        :height_with_socket, :width_with_socket, :depth_with_socket, :framing
      ]
      fields.each do |f|
        if se[f].present?
          se.update_column "#{f}_reverse".to_sym, se[f].reverse
        end
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

end
