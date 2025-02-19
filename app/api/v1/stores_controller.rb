module V1
  class StoresController < ApiController
    before_action :set_store, only: [:show, :destroy, :update]
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

      render json: StoreBlueprint.render(store)
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

      render json: { message: 'Tienda eliminada correctamente' }
    end

    private

    def set_store
      @store = Store.find_by!(uuid: params[:uuid])
    end
  end
end
