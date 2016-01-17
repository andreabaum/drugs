json.array!(@purchases) do |purchase|
  json.extract! purchase, :id, :when, :note, :amount
  json.url purchase_url(purchase, format: :json)
end
