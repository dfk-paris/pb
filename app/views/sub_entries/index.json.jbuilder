json.array! @sub_entries do |se|
  json.partial! 'item', sub_entry: se
end