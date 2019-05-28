class OrderSerializer < ActiveModel::Serializer
  attributes :id, :description, :created_at, :updated_at
  belongs_to :customer
  has_many :line_items
end
