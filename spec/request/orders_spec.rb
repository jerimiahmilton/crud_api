require 'rails_helper'

RSpec.describe 'orders API', type: :request do
  before { host! 'api.localhost:3000' }

  let!(:customer) { create(:customer) }
  let(:customer_id) { customer.id }
  let!(:orders) { create_list(:order, 10, customer_id: customer_id) }
  let(:order) { orders.sample }
  let(:order_id) { order.id }

  describe 'GET /v1/customers/:customer_id/orders' do
    before { get "/v1/customers/#{customer_id}/orders" }

    it 'returns orders' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /v1/customers/:customer_id/orders/:id' do
    before { get "/v1/customers/#{customer_id}/orders/#{order_id}" }

    context 'when the record exists' do
      it 'returns the order' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq("#{order_id}")
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let (:order_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Order/)
      end
    end
  end

  describe 'POST /v1/customers/:customer_id/orders' do
    let(:valid_attributes) { { description: 'Acme Gears' } }

    context 'when the request is valid' do
      before { post "/v1/customers/#{customer_id}/orders", params: valid_attributes }

      it 'creates an order' do
        expect(json['data'].last['attributes']['description']).to eq('Acme Gears')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post "/v1/customers/#{customer_id}/orders", params: { descriptions: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Description can't be blank/)
      end
    end
  end

  describe 'PUT /v1/customers/:customer_id/orders/:order_id' do
    let(:valid_attributes) { { description: 'Acme Gears' } }

    context 'when the record exists' do
      before { put "/v1/customers/#{customer_id}/orders/#{order_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /v1/customers/:customer_id/orders/:order_id' do
    before { delete "/v1/customers/#{customer_id}/orders/#{order_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
