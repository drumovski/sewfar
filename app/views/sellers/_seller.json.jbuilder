json.extract! seller, :id, :business_name, :abn, :website, :facebook, :twitter, :linkedin, :instagram, :about, :address_line_1, :address_line_2, :city, :postcode, :country, :created_at, :updated_at
json.url seller_url(seller, format: :json)
