json.array!(@events) do |event|
  json.extract! event, :location_id, :name, :description, :date_start, :date_end
  json.url event_url(event, format: :json)
end
