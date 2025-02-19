module Orders
  module StateChanges
    class Pay < BaseService
      def initialize(order:)
        @order = order
      end

      def execute
        Order.transaction do
          @order.pay!
        end
        # Aqui se enviaría el correo
      end
    end
  end
end
