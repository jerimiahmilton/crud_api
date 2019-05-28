class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at
  has_many :orders
end
