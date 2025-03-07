require 'rails_helper'

RSpec.describe V1::StoresController, type: :request do
  describe "GET /api/v1/stores" do
    before do
      create_list(:store, 3)
    end

    it "returns all stores" do
      get "/api/v1/stores"
      
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "POST /api/v1/stores" do
    let(:valid_attributes) do
      {
        name: "Papa John's",
        phone: "123-456-7890",
        email: "papa@johns.com",
        street: "Calle Principal 123",
        number: 123,
        letter: "A",
        postal_code: "12345",
        city: "Ciudad",
        country: "País"
      }
    end

    it "creates a new store" do
      expect {
        post "/api/v1/stores", params: valid_attributes
      }.to change(Store, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["name"]).to eq("Papa John's")
    end

    it "returns a 422 error if the store is invalid" do
      post "/api/v1/stores", params: {
        name: nil,
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /api/v1/stores/:uuid" do
    let(:store) { create(:store) }

    it "returns the store" do
      get "/api/v1/stores/#{store.uuid}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["name"]).to eq(store.name)
    end

    it "returns a 404 error if the store is not found" do
      get "/api/v1/stores/123"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PUT /api/v1/stores/:uuid" do
    let(:store) { create(:store) }

    it "updates the store" do
      put "/api/v1/stores/#{store.uuid}", params: {
        name: "Papa John's 2",
        phone: "123-456-7890",
        email: "papa@johns.com",
        street: "Calle Principal 123",
        number: 123,
        letter: "A",
        postal_code: "12345",
        city: "Ciudad",
        country: "País"
      }

      expect(response).to have_http_status(:ok)
      expect(store.reload.name).to eq("Papa John's 2")
    end

    it "returns a 404 error if the store is not found" do
      put "/api/v1/stores/123", params: {
        name: "Papa John's 2",
      }

      expect(response).to have_http_status(:not_found)
    end

    it "returns a 422 error if the store is invalid" do
      put "/api/v1/stores/#{store.uuid}", params: {
        name: nil,
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /api/v1/stores/:uuid" do
    let!(:store) { create(:store) }

    it "deletes the store" do
      expect {
        delete "/api/v1/stores/#{store.uuid}"
      }.to change(Store, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end

  describe "POST /api/v1/stores/:uuid/assign_products" do
    let(:store) { create(:store) }
    let(:product) { create(:product) }

    it "assigns products to the store" do
      post "/api/v1/stores/#{store.uuid}/assign_products", params: {
        product_uuids: product.uuid
      }

      expect(response).to have_http_status(:ok)
      expect(store.products).to include(product)
      expect(store.products.count).to eq(1)
    end

    it "returns a 404 error if the store is not found" do
      post "/api/v1/stores/123/assign_products", params: {
        product_uuids: product.uuid
      }

      expect(response).to have_http_status(:not_found)
    end

    it "returns a 422 error if the product is not found" do
      post "/api/v1/stores/#{store.uuid}/assign_products", params: {
        product_uuids: "123"
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /api/v1/stores/:uuid/unassign_products" do
    let(:store) { create(:store) }
    let(:product) { create(:product) }

    it "unassigns products from the store" do
      post "/api/v1/stores/#{store.uuid}/assign_products", params: {
        product_uuids: product.uuid
      }

      delete "/api/v1/stores/#{store.uuid}/unassign_products", params: {
        product_uuids: product.uuid
      }

      expect(response).to have_http_status(:ok)
      expect(store.products).not_to include(product)
      expect(store.products.count).to eq(0)
    end

    it "returns a 404 error if the store is not found" do
      delete "/api/v1/stores/123/unassign_products", params: {
        product_uuids: product.uuid
      }

      expect(response).to have_http_status(:not_found)
    end

    it "returns a 422 error if the product is not found" do
      delete "/api/v1/stores/#{store.uuid}/unassign_products", params: {
        product_uuids: "123"
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /api/v1/stores/:uuid/products" do
    let(:store) { create(:store) }
    let(:product) { create(:product) }

    it "returns the products of the store" do
      post "/api/v1/stores/#{store.uuid}/assign_products", params: {
        product_uuids: product.uuid
      }

      get "/api/v1/stores/#{store.uuid}/products"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body)[0]["uuid"]).to eq(product.uuid)
    end

    it "returns a 404 error if the store is not found" do
      get "/api/v1/stores/123/products"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /api/v1/stores/:uuid/orders" do
    let(:store) { create(:store) }
    let!(:order) { create(:order, store: store) }

    it "returns the orders of the store" do
      get "/api/v1/stores/#{store.uuid}/orders" 
  
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body)[0]["uuid"]).to eq(order.uuid)
    end

    it "returns a 404 error if the store is not found" do
      get "/api/v1/stores/123/orders"

      expect(response).to have_http_status(:not_found)
    end
  end
end
