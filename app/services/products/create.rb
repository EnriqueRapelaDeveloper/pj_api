module Products
  class Create < BaseService
    def initialize(name:, sku:, kind:, price:, description:)
      @name = name
      @sku = sku
      @kind = kind
      @price = price
      @description = description
    end

    def execute
      Product.transaction do
        product = Product.create!(name: @name,
                                  sku: @sku,
                                  kind: @kind.to_i,
                                  price: @price,
                                  description: @description)

        product
      end
    end
  end
end
