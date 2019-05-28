require 'rails_helper'

RSpec.describe 'Customer routing', type: :routing do
  describe 'GET /v1/customers' do
    it 'routes to customers#index for all customers' do
      expect(get: 'http://api.localhost:3000/v1/customers').to route_to(subdomain: 'api', controller: 'api/v1/customers', action: 'index')
    end
  end

  describe 'GET /v1/customers/:id' do
    it 'routes to customers#show for customer_id' do
      expect(get: 'http://api.localhost:3000/v1/customers/1').to route_to(subdomain: 'api', controller: 'api/v1/customers', action: 'show', id: '1')
    end
  end

  describe 'POST /v1/customers' do
    it 'routes to customers#create' do
      expect(post: 'http://api.localhost:3000/v1/customers').to route_to(subdomain: 'api', controller: 'api/v1/customers', action: 'create')
    end
  end

  describe 'PUT /v1/customers/:id' do
    it 'routes to customers#update for customer_id' do
      expect(put: 'http://api.localhost:3000/v1/customers/1').to route_to(subdomain: 'api', controller: 'api/v1/customers', action: 'update', id: '1')
    end
  end

  describe 'DELETE /v1/customers/:id' do
    it 'routes to customers#destroy for customer_id' do
      expect(delete: 'http://api.localhost:3000/v1/customers/1').to route_to(subdomain: 'api', controller: 'api/v1/customers', action: 'destroy', id: '1')
    end
  end
end
