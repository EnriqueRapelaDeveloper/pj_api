module Orders
  module StateChanges
    class Deliver < BaseService
      def initialize(order:)
        @order = order
      end

      def execute
        Order.transaction do
          @order.deliver!
        end
      end
    end
  end
end
