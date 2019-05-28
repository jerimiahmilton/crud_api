class Order < ApplicationRecord
  belongs_to :customer, validate: true
  has_many :line_items, dependent: :destroy

  validates :customer, presence: true
  validates :description, presence: true
end
