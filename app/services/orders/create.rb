module Orders
  class Create < BaseService
    def initialize(store_uuid:, products:)
      @store_uuid = store_uuid
      @products   = products
    end

    def execute
      Order.transaction do
        store = Store.find_by(uuid: @store_uuid)

        raise ArgumentError, "Tienda no encontrada" if store.nil?

        order = Order.create!(store: store, status: 0)

        @products.each do |product_data|
          product = Product.find_by(uuid: product_data[:product_uuid])
          store_product = StoreProduct.find_by(store: store, product: product)

          raise ArgumentError, "Producto no encontrado en la tienda" if store_product.nil?

          OrderProduct.create!(order: order, product: product, quantity: product_data[:quantity])
        end

        ::Orders::CalculateTotalAmount.execute(order)

        order.reload
      end
    end
  end
end
