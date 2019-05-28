class Order < ApplicationRecord
  belongs_to :customer, validate: true

  validates :customer, presence: true
  validates :description, presence: true
end
