module Orders
  module StateChanges
    class Cancel < BaseService
      def initialize(order:)
        @order = order
      end

      def execute
        Order.transaction do
          @order.cancel!
        end
      end
    end
  end
end
