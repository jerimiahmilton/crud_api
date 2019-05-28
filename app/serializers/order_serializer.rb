class OrderSerializer < ActiveModel::Serializer
  attributes :id, :description, :created_at, :updated_at
  belongs_to :customer
end
