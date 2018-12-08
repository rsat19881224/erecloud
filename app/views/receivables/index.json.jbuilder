json.array!(@receivables) do |receivable|
  json.extract! receivable, :id
  json.url receivable_url(receivable, format: :json)
end
