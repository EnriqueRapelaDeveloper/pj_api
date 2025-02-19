module Orders
  class Update < BaseService
    def initialize(order:, products:)
      @order = order
      @products = products
    end

    def execute
      Order.transaction do
        raise ArgumentError, "No se puede actualizar un pedido pagado o entregado" if @order.paid? || @order.delivered? || @order.cancelled?

        OrderProduct.where(order: @order).destroy_all

        @products.each do |product_data|
          product = Product.find_by(uuid: product_data[:product_uuid])

          store_product = StoreProduct.find_by(store: @order.store, product: product)

          raise ArgumentError, "Producto no encontrado en la tienda" if store_product.nil?

          OrderProduct.create!(order: @order, product: product, quantity: product_data[:quantity])
        end

        ::Orders::CalculateTotalAmount.execute(@order)

        @order.reload
      end
    end
  end
end
