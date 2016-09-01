json.message @message
json.sub_entry do
  json.partial! 'item', sub_entry: @sub_entry
end
json.errors @sub_entry.errors