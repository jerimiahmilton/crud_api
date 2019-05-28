require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to(:customer) }
  it { should have_many(:line_items).dependent(:destroy) }
  it { should validate_presence_of(:description) }
end
