require 'rails_helper'

RSpec.describe V1::OrdersController, type: :controller do
  describe 'GET #show' do
    let(:store) { create(:store) }
    let(:order) { create(:order, store: store) }

    it 'returns the requested order' do
      get :show, params: { uuid: order.uuid }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['uuid']).to eq(order.uuid)
    end
  end

  describe 'POST #create' do
    let(:store) { create(:store) }
    let(:product) { create(:product) }
    let!(:store_product) { create(:store_product, store: store, product: product) }
    let(:valid_params) do
      {
        "store_uuid": store.uuid,
        "products": [
          {
            "product_uuid": product.uuid,
            "quantity": 2
          }
        ]
      }
    end

    it 'creates a new order successfully' do
      expect {
        post :create, params: valid_params
      }.to change(Order, :count).by(1)
      
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['total_price']).to eq((product.price.to_f * 2) / 100)
      expect(JSON.parse(response.body)['status']).to eq('draft')
    end

    it 'returns an error when the product is not found' do
      expect {
        post :create, params: { store_uuid: store.uuid, products: [{ product_uuid: 'non_existent_uuid', quantity: 2 }] }
      }.not_to change(Order, :count)
      
      expect(response).to have_http_status(:unprocessable_entity) 
    end

    it 'returns an error when the store is not found' do
      expect {
        post :create, params: { store_uuid: 'non_existent_uuid', products: [{ product_uuid: product.uuid, quantity: 2 }] }
      }.not_to change(Order, :count)
      
      expect(response).to have_http_status(:unprocessable_entity)
    end 
  end

  describe 'PATCH #update' do
    let(:store) { create(:store) }
    let(:product) { create(:product) }
    let!(:store_product) { create(:store_product, store: store, product: product) }
    let(:order) { create(:order, store: store) }

    it 'updates order total_amount' do
      patch :update, params: { uuid: order.uuid, products: [{ product_uuid: product.uuid, quantity: 2 }] }
      
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['total_price']).to eq((product.price.to_f * 2) / 100)
    end

    it 'returns an error when the product is not found' do
      patch :update, params: { uuid: order.uuid, products: [{ product_uuid: 'non_existent_uuid', quantity: 2 }] }
      
      expect(response).to have_http_status(:unprocessable_entity)
    end 

    it 'returns an error when the store is not found' do
      patch :update, params: { uuid: 'non_existent_uuid', products: [{ product_uuid: product.uuid, quantity: 2 }] }
      
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'State machine transitions' do
    describe 'POST #pay' do
      let(:order) { create(:order) }

      it 'changes order state from pending to paid' do
        post :pay, params: { uuid: order.uuid }
        
        expect(response).to have_http_status(:ok)
        order.reload
        expect(order.status).to eq('paid')
      end

      it 'fails when trying to pay an already paid order' do
        order.update(status: 'paid')
        post :pay, params: { uuid: order.uuid }
        
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'fails when trying to pay a cancelled order' do
        order.update(status: 'cancelled')
        post :pay, params: { uuid: order.uuid }
        
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe 'POST #cancel' do
      let(:order) { create(:order) }

      it 'changes order state from pending to cancelled' do
        post :cancel, params: { uuid: order.uuid }
        
        expect(response).to have_http_status(:ok)
        order.reload
        expect(order.status).to eq('cancelled')
      end

      it 'fails when trying to cancel a paid order' do
        order.update(status: 'paid')
        post :cancel, params: { uuid: order.uuid }
        
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'fails when trying to cancel an already cancelled order' do
        order.update(status: 'cancelled')
        post :cancel, params: { uuid: order.uuid }
        
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
