class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :merchant_id
end
