module V1
  class OrdersController < ApiController
    before_action :set_order, only: [:update, :show, :pay, :deliver, :cancel]
    def create
      order = ::Orders::Create.execute(store_uuid: params[:store_uuid], products: order_products_params)

      render json: OrderBlueprint.render(order)
    end

    def update
      order = ::Orders::Update.execute(order: @order, products: order_products_params)

      render json: OrderBlueprint.render(order)
    end

    def show
      render json: OrderBlueprint.render(@order)
    end

    # State change actions
    def pay
      ::Orders::StateChanges::Pay.execute(order: @order)

      render json: OrderBlueprint.render(@order)
    end

    def deliver
      ::Orders::StateChanges::Deliver.execute(order: @order)

      render json: OrderBlueprint.render(@order)
    end

    def cancel
      ::Orders::StateChanges::Cancel.execute(order: @order)

      render json: OrderBlueprint.render(@order)
    end

    private

    def set_order
      @order = Order.find_by!(uuid: params[:uuid])
    end

    def order_products_params
      params.require(:products).map do |product|
        product.permit(:product_uuid, :quantity)
      end
    end
  end
end
