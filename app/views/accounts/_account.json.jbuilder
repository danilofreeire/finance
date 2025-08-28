json.extract! account, :id, :name, :kind, :opening_balance, :created_at, :updated_at
json.url account_url(account, format: :json)
