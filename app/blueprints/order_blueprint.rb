class OrderBlueprint < Blueprinter::Base
  identifier :uuid
  field :total_price do |order|
    order.total_price.to_f / 100
  end
  field :status
  field :created_at

  field :products do |order|
    order.products.map do |product|
      {
        uuid: product.uuid,
        name: product.name,
        price: product.price.to_f / 100,
        quantity: order.order_products.find_by(product: product).quantity
      }
    end
  end
end
