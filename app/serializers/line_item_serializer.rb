class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :price, :qty, :description, :created_at, :updated_at
  belongs_to :order
end
