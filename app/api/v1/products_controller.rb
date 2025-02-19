module V1
  class ProductsController < ApiController
    before_action :set_product, only: [:show, :update, :destroy]

    def index
      render json: ProductBlueprint.render(Product.all)
    end

    def create
      product = ::Products::Create.execute(name: params[:name],
                                           sku: params[:sku],
                                           kind: params[:kind],
                                           price: params[:price],
                                           description: params[:description])

      render json: ProductBlueprint.render(product)
    end

    def show
      render json: ProductBlueprint.render(@product)
    end

    def update
      product = ::Products::Update.execute(product: @product,
                                           name: params[:name],
                                           sku: params[:sku],
                                           kind: params[:kind],
                                           price: params[:price],
                                           description: params[:description])

      render json: ProductBlueprint.render(product)
    end

    def destroy
      @product.destroy

      render json: { message: 'Producto eliminado correctamente' }, status: :no_content
    end

    private

    def set_product
      @product = Product.find_by!(uuid: params[:uuid])
    end
  end
end
