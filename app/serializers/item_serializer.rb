class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :unit_price
  attributes :merchant_id do |object|
    object.merchant_id
  end
  belongs_to :merchant
end
