module Stores
  class UnassignProducts < BaseService
    def initialize(store:, product_uuids:)
      @store = store
      @product_uuids = product_uuids
    end

    def execute
      StoreProduct.transaction do
        @product_uuids.split(',').each do |product_uuid|
          product = Product.find_by(uuid: product_uuid.strip)

          raise ActiveRecord::AssociationTypeMismatch, "Producto no encontrado con UUID: #{product_uuid.strip}" if product.nil?

          StoreProduct.find_by(store: @store, product: product).destroy
        end
      end
    end
  end
end
