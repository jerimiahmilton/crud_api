require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it { should belong_to(:order) }
  it { should validate_numericality_of(:price) }
  it { should validate_numericality_of(:qty) }
  it { should validate_presence_of(:description) }
end
