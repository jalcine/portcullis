json.description @ticket.description
json.name @ticket.name
json.event @ticket.event.id.to_i
json.id @ticket.id.to_i
json.price @ticket.price
json.dates do
  json.start @ticket.date_start
  json.end @ticket.date_end
end
