json.main_entry do
  json.id sub_entry.main_entry.id
  json.title sub_entry.main_entry.title
  json.group sub_entry.main_entry.group
  json.location sub_entry.main_entry.location
  json.sequence sub_entry.main_entry.sequence
end

json.id sub_entry.id
json.title sub_entry.title
json.sequence sub_entry.sequence
json.description sub_entry.description
json.inventory_ids sub_entry.inventory_ids.map{|t| t.name}

json.media sub_entry.media do |medium|
  json.partial! 'media/item', medium: medium
end