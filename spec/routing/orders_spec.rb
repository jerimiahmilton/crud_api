require 'rails_helper'

RSpec.describe 'Order routing', type: :routing do
  describe 'GET /v1/customers/:customer_id/orders' do
    it 'routes to orders#index for customer' do
      expect(get: 'http://api.localhost:3000/v1/customers/1/orders').to route_to(subdomain: 'api', controller: 'api/v1/orders', action: 'index', customer_id: '1')
    end
  end

  describe 'GET /v1/customers/:customer_id/orders/:id' do
    it 'routes to orders#show for order_id' do
      expect(get: 'http://api.localhost:3000/v1/customers/1/orders/1').to route_to(subdomain: 'api', controller: 'api/v1/orders', action: 'show', id: '1', customer_id: '1')
    end
  end

  describe 'POST /v1/customers/:customer_id/orders' do
    it 'routes to orders#create' do
      expect(post: 'http://api.localhost:3000/v1/customers/1/orders').to route_to(subdomain: 'api', controller: 'api/v1/orders', action: 'create', customer_id: '1')
    end
  end

  describe 'PUT /v1/customers/:customer_id/orders/:id' do
    it 'routes to orders#update for order_id' do
      expect(put: 'http://api.localhost:3000/v1/customers/1/orders/1').to route_to(subdomain: 'api', controller: 'api/v1/orders', action: 'update', id: '1', customer_id: '1')
    end
  end

  describe 'DELETE /v1/customers/:customer_id/orders/:id' do
    it 'routes to orders#destroy for order_id' do
      expect(delete: 'http://api.localhost:3000/v1/customers/1/orders/1').to route_to(subdomain: 'api', controller: 'api/v1/orders', action: 'destroy', id: '1', customer_id: '1')
    end
  end
end
