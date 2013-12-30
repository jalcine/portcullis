json.extract! @ticket, :name, :date_end, :date_start, :description, :price
json.html render partial: 'tickets/stub.html', locals: { ticket: @ticket }
