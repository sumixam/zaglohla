json.array!(@admin_administrators) do |admin_administrator|
  json.extract! admin_administrator, :email, :password, :acl
  json.url admin_administrator_url(admin_administrator, format: :json)
end
