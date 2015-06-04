json.array!(@admin_ctos) do |admin_cto|
  json.extract! admin_cto, :name, :description, :adress_street, :adress_buildng, :adress_additional, :site, :email, :gov_certificate, :manufacture_certificate
  json.url admin_cto_url(admin_cto, format: :json)
end
