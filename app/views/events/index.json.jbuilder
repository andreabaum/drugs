json.array!(@events) do |event|
  json.extract! event, :id, :when, :resource, :resource_id, :description
  json.url event_url(event, format: :json)
end
