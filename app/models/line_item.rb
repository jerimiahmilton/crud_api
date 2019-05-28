class LineItem < ApplicationRecord
  belongs_to :order

  validates :order, :description, presence: true
  validates :price, presence: true, numericality: true
  validates :qty, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
