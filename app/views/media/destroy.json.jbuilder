json.message @message
json.medium do
  json.partial! 'item', medium: @medium
end