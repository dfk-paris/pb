json.total @main_entries.limit(nil).reorder(nil).offset(nil).count
json.page params[:page] || 1
json.items do
  json.array! @main_entries do |me|
    json.partial! 'item', main_entry: me
  end
end