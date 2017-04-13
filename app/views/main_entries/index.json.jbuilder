json.total @main_entries.limit(nil).reorder(nil).offset(nil).count
json.per_page (params[:per_page] || 10).to_i
json.page params[:page] || 1
json.items do
  json.array! @main_entries do |me|
    json.partial! 'item', main_entry: me, include_sub_entries: true
  end
end