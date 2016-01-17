json.array!(@drugs) do |drug|
  json.extract! drug, :id, :name, :note, :active
  json.url drug_url(drug, format: :json)
end
