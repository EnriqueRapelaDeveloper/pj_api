class ProductBlueprint < Blueprinter::Base
  identifier :uuid
  fields :name, :sku, :kind, :description

  field :price do |product|
    product.price.to_f / 100
  end
end
