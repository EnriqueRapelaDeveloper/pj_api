# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::ProductsController, type: :request do
  let(:valid_attributes) do
    {
      name: 'Producto Test',
      sku: 'SKU123',
      kind: 0,
      price: 1999,
      description: 'Descripción del producto'
    }
  end

  let(:invalid_attributes) do
    {
      name: '',
      sku: '',
      kind: '',
      price: nil,
      description: ''
    }
  end

  describe 'GET /api/v1/products' do
    before do
      create_list(:product, 3)
      get '/api/v1/products'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all products' do
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET /api/v1/products/:uuid' do
    let(:product) { create(:product) }

    context 'when product exists' do
      before { get "/api/v1/products/#{product.uuid}" }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the product' do
        expect(JSON.parse(response.body)['uuid']).to eq(product.uuid)
      end
    end

    context 'when product does not exist' do
      before { get '/api/v1/products/invalid-uuid' }

      it 'returns http not_found' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /api/v1/products' do
    context 'with valid parameters' do
      before { post '/api/v1/products', params: valid_attributes }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'creates a new product' do
        expect(Product.count).to eq(1)
      end
    end

    context 'with invalid parameters' do
      before { post '/api/v1/products', params: invalid_attributes }

      it 'returns http unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/v1/products/:uuid' do
    let(:product) { create(:product) }
    let(:update_attributes) do
      {
        name: 'Pizza actualizada',
        sku: 'NEWSKU123',
        kind: 0,
        price: 2999,
        description: 'Nueva descripción'
      }
    end

    context 'with valid parameters' do
      before { put "/api/v1/products/#{product.uuid}", params: update_attributes }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'updates the product' do
        product.reload

        expect(product.name).to eq('Pizza actualizada')
        expect(product.sku).to eq('NEWSKU123')
        expect(product.kind).to eq('pizza')
        expect(product.price).to eq(2999)
        expect(product.description).to eq('Nueva descripción')
      end
    end

    context 'with invalid parameters' do
      before { put "/api/v1/products/#{product.uuid}", params: invalid_attributes }

      it 'returns http unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /api/v1/products/:uuid' do
    let!(:product) { create(:product) }

    context 'when product exists' do
      before { delete "/api/v1/products/#{product.uuid}" }

      it 'returns http no_content' do
        expect(response).to have_http_status(:no_content)
      end

      it 'deletes the product' do
        expect(Product.count).to eq(0)
      end
    end

    context 'when product does not exist' do
      before { delete '/api/v1/products/invalid-uuid' }

      it 'returns http not_found' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end 