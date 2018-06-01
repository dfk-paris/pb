class AddTitleToPeopleIndex < ActiveRecord::Migration[5.0]
  def up
    MainEntry.find_each do |e|
      e.wikidata_people(:title)
      e.save
    end

    SubEntry.find_each do |e|
      e.wikidata_people(:title)
      e.save
    end
  end

  def down
    # nothing to do
  end
end
