module V1
  class StoresController < ApiController
    before_action :set_store, only: [:show, :destroy, :update, :assign_products, :unassign_products, :products, :orders]
    def index
      render json: StoreBlueprint.render(Store.all)
    end

    def create
      store = ::Stores::Create.execute(name: params[:name],
                                       phone: params[:phone],
                                       email: params[:email],
                                       street: params[:street],
                                       number: params[:number],
                                       letter: params[:letter],
                                       postal_code: params[:postal_code],
                                       country: params[:country],
                                       city: params[:city])

      render json: StoreBlueprint.render(store), status: :created
    end

    def show
      render json: StoreBlueprint.render(@store)
    end

    def update
      store = ::Stores::Update.execute(store: @store,
                                       name: params[:name],
                                       phone: params[:phone],
                                       email: params[:email],
                                       street: params[:street],
                                       number: params[:number],
                                       letter: params[:letter],
                                       postal_code: params[:postal_code],
                                       country: params[:country],
                                       city: params[:city])

      render json: StoreBlueprint.render(store)
    end

    def destroy
      @store.destroy

      render json: { message: 'Tienda eliminada correctamente' }, status: :no_content
    end

    def assign_products
      ::Stores::AssignProducts.execute(store: @store, product_uuids: params[:product_uuids])

      render json: StoreBlueprint.render(@store), status: :ok
    end

    def unassign_products
      ::Stores::UnassignProducts.execute(store: @store, product_uuids: params[:product_uuids])

      render json: StoreBlueprint.render(@store), status: :ok
    end

    def products
      render json: ProductBlueprint.render(@store.products)
    end

    def orders
      render json: OrderBlueprint.render(@store.orders)
    end

    private

    def set_store
      @store = Store.find_by!(uuid: params[:uuid])
    end
  end
end
