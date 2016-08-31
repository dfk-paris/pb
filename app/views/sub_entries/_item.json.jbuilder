json.extract!(sub_entry, 
  :id, :main_entry_id,
  :sequence, :title, :no_title, :description, 
  :creator, :location, :dating, 
  :height, :width, :depth, :diameter, :weight, 
  :height_with_socket, :width_with_socket, :depth_with_socket, 
  :markings, :material, :framing, :restaurations,
  :created_at, :updated_at
)
json.inventory_ids sub_entry.inventory_ids.map{|t| t.name}

media = (local_assigns[:only_published] ? sub_entry.media.published : sub_entry.media)

json.media media do |medium|
  json.partial! 'media/item', medium: medium
end

if local_assigns[:include_main_entry]
  json.main_entry do
    json.partial! 'main_entries/item', main_entry: sub_entry.main_entry
  end
end