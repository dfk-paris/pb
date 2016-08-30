json.extract!(medium,
  :id, :sub_entry_id,
  :caption, :sequence, :publish,
  :created_at, :updated_at
)

json.file_name medium.image_file_name
json.content_type medium.image_content_type
json.size medium.image_file_size

json.urls do
  json.original medium.image.url(:original)
  json.thumb medium.image.url(:thumb)
  json.normal medium.image.url(:normal)
  json.big medium.image.url(:big)
end