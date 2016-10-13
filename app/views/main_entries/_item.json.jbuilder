json.extract!(main_entry,
  :id, :title, :location, :sequence,
  :created_at, :updated_at,
  :provenience, :historical_evidence, :literature, :description, :appreciation,
  :publish
)

if local_assigns[:include_sub_entries]
  json.sub_entries do
    json.array! main_entry.sub_entries do |se|
      json.partial! "sub_entries/item", sub_entry: se
    end
  end
end