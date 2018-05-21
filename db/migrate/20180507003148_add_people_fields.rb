class AddPeopleFields < ActiveRecord::Migration[5.0]
  def change
    add_column :main_entries, :people, :text
    add_column :sub_entries, :people, :text

    ActiveRecord::Base.record_timestamps = false

    MainEntry.all.each do |me|
      me.wikidata_people(:provenience)
      me.wikidata_people(:historical_evidence)
      me.wikidata_people(:literature)
      me.wikidata_people(:description)
      me.wikidata_people(:appreciation)
      me.save
    end

    SubEntry.all.each do |se|
      se.wikidata_people(:markings)
      se.wikidata_people(:restaurations)
      se.wikidata_people(:framing)
      se.wikidata_people(:creator)
      se.save
    end

    ActiveRecord::Base.record_timestamps = true
  end
end
