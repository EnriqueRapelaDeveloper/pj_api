module Products
  class Update < BaseService
    def initialize(product:, name:, sku:, kind:, price:, description:)
      @product = product
      @name = name
      @sku = sku
      @kind = kind
      @price = price
      @description = description
    end

    def execute
      Product.transaction do
        @product.update!(name: @name, sku: @sku, kind: @kind.to_i, price: @price, description: @description)

        @product
      end
    end
  end
end
