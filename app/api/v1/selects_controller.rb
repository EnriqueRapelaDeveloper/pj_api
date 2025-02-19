module V1
  class SelectsController < ApiController
    def product_kinds
      render json: IdNameSelectBlueprint.render(Product.kinds.map { |product_id, product_value| { id: product_id, name: product_value } })
    end
  end
end
