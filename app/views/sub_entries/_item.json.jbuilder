json.extract!(sub_entry, 
  :id, :main_entry_id,
  :sequence, :title, :description, 
  :creator, :location, :dating, 
  :height, :width, :depth, :diameter, :weight, 
  :height_with_socket, :width_with_socket, :depth_with_socket, 
  :markings, :material, :framing, :restaurations,
  :created_at, :updated_at
)
json.inventory_ids sub_entry.inventory_ids.map{|t| t.name}

json.media sub_entry.media do |medium|
  json.partial! 'media/item', medium: medium
end