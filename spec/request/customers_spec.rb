require 'rails_helper'

RSpec.describe 'Customers API', type: :request do
  before { host! 'api.localhost:3000' }
    
  let!(:customers) { create_list(:customer, 10) }
  let(:customer) { customers.sample }
  let(:customer_id) { customer.id }

  describe 'GET /v1/customers' do
    before { get '/v1/customers' }

    it 'returns customers' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /v1/customers/:id' do
    before { get "/v1/customers/#{customer_id}" }

    context 'when the record exists' do
      it 'returns the customer' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq("#{customer_id}")
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:customer_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Customer/)
      end
    end
  end

  describe 'POST /v1/customers' do
    let(:valid_attributes) { { name: 'Albert Einstein' } }

    context 'when the request is valid' do
      before { post '/v1/customers', params: valid_attributes }

      it 'creates a customer' do
        expect(json['data']['attributes']['name']).to eq('Albert Einstein')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/v1/customers', params: { name: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Name can't be blank/)
      end
    end
  end

  describe 'PUT /v1/customers/:id' do
    let(:valid_attributes) { { name: 'Nichola Tesla' } }

    context 'when the record exists' do
      before { put "/v1/customers/#{customer_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns stauts code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /v1/customers/:id' do
    before { delete "/v1/customers/#{customer_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
