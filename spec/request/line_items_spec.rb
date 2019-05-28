require 'rails_helper'

RSpec.describe 'line items API', type: :request do
  before { host! 'api.localhost:3000' }

  let!(:customer) { create(:customer) }
  let(:customer_id) { customer.id }
  let!(:orders) { create_list(:order, 10, customer_id: customer_id) }
  let(:order) { orders.sample }
  let(:order_id) { order.id }
  let!(:line_items) { create_list(:line_item, 10, order_id: order_id) }
  let(:line_item) { line_items.sample }
  let(:line_item_id) { line_item.id }

  describe 'GET /v1/customers/:customer_id/orders/:order_id/line_items' do
    before { get "/v1/customers/#{customer_id}/orders/#{order_id}/line_items" }

    it 'returns line items' do
      puts order.inspect
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /v1/customers/:customer_id/orders/:order_id/line_items/:id' do
    before { get "/v1/customers/#{customer_id}/orders/#{order_id}/line_items/#{line_item_id}" }

    context 'when the record exists' do
      it 'returns the line item' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq("#{line_item_id}")
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let (:line_item_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find LineItem/)
      end
    end
  end

  describe 'POST /v1/customers/:customer_id/orders/:order_id/line_items' do
    let(:valid_attributes) { { price: 10.99, qty: 5, description: 'Acme Gears' } }

    context 'when the request is valid' do
      before { post "/v1/customers/#{customer_id}/orders/#{order_id}/line_items", params: valid_attributes }

      it 'creates a line item' do
        expect(json['data'].last['attributes']['description']).to eq('Acme Gears')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post "/v1/customers/#{customer_id}/orders/#{order_id}/line_items", params: { descriptions: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Description can't be blank/)
      end
    end
  end

  describe 'PUT /v1/customers/:customer_id/orders/:order_id/line_items/:id' do
    let(:valid_attributes) { { price: 10.99, qty: 5, description: 'Acme Gears' } }

    context 'when the record exists' do
      before { put "/v1/customers/#{customer_id}/orders/#{order_id}/line_items/#{line_item_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /v1/customers/:customer_id/orders/:order_id/line_items/:id' do
    before { delete "/v1/customers/#{customer_id}/orders/#{order_id}/line_items/#{line_item_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
