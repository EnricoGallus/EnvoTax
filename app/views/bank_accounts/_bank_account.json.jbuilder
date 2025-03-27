json.extract! bank_account, :id, :account_holder, :bank_name, :branch_code, :account_number, :accountable_id, :accountable_type, :created_at, :updated_at
json.url bank_account_url(bank_account, format: :json)
