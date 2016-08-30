json.id medium.id
json.sub_entry_id medium.sub_entry_id
# json.is_default medium.is_default
json.caption medium.caption

json.publish medium.publish
json.file_name medium.image_file_name
json.content_type medium.image_content_type
json.size medium.image_file_size
json.created_at medium.created_at
json.updated_at medium.updated_at

json.urls do
  json.original medium.image.url(:original)
  json.thumb medium.image.url(:thumb)
  json.normal medium.image.url(:normal)
  json.big medium.image.url(:big)
end