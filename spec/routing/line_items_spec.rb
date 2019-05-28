require 'rails_helper'

RSpec.describe 'Line Item routing', type: :routing do
  describe 'GET /v1/customers/:customer_id/orders/:order_id/line_item' do
    it 'routes to line_items#index for order' do
      expect(get: 'http://api.localhost:3000/v1/customers/1/orders/1/line_items').to route_to(subdomain: 'api', controller: 'api/v1/line_items', action: 'index', customer_id: '1', order_id: '1')
    end
  end

  describe 'GET /v1/customers/:customer_id/orders/:order_id/line_items/:id' do
    it 'routes to line_items#show for line_item_id' do
      expect(get: 'http://api.localhost:3000/v1/customers/1/orders/1/line_items/1').to route_to(subdomain: 'api', controller: 'api/v1/line_items', action: 'show', id: '1', customer_id: '1', order_id: '1')
    end
  end

  describe 'POST /v1/customers/:customer_id/orders/:order_id/line_items' do
    it 'routes to line_items#create' do
      expect(post: 'http://api.localhost:3000/v1/customers/1/orders/1/line_items').to route_to(subdomain: 'api', controller: 'api/v1/line_items', action: 'create', customer_id: '1', order_id: '1')
    end
  end

  describe 'PUT /v1/customers/:customer_id/orders/:order_id/line_items/:id' do
    it 'routes to line_items#update for line_item_id' do
      expect(put: 'http://api.localhost:3000/v1/customers/1/orders/1/line_items/1').to route_to(subdomain: 'api', controller: 'api/v1/line_items', action: 'update', id: '1', customer_id: '1', order_id: '1')
    end
  end

  describe 'DELETE /v1/customers/:customer_id/orders/:order_id/line_items/:id' do
    it 'routes to line_items#destroy for line_item_id' do
      expect(delete: 'http://api.localhost:3000/v1/customers/1/orders/1/line_items/1').to route_to(subdomain: 'api', controller: 'api/v1/line_items', action: 'destroy', id: '1', customer_id: '1', order_id: '1')
    end
  end
end
