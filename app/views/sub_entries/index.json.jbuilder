json.array! @sub_entries do |se|
  json.main_entry do
    json.id se.main_entry.id
    json.title se.main_entry.title
    json.group se.main_entry.group
    json.location se.main_entry.location
    json.sequence se.main_entry.sequence
  end

  json.title se.title
  json.sequence se.sequence
  json.description se.description
  json.inventory_ids se.inventory_ids.map{|t| t.name}
end