module Orders
  class CalculateTotalAmount < BaseService
    def initialize(order)
      @order = order
    end

    def execute
      @order.update_attribute(:total_price, calculate_total_amount)
    end

    private

    def calculate_total_amount
      @order.order_products.sum do |order_product|
        order_product.quantity * order_product.product.price
      end
    end
  end
end
