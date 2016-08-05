class RenameHistoricEvidence < ActiveRecord::Migration[5.0]
  def change
    change_table :main_entries do |t|
      t.rename :historic_evidence, :historical_evidence
    end
  end
end
