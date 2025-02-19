class ProductBlueprint < Blueprinter::Base
  identifier :uuid
  fields :name, :sku, :kind, :description

  field :price do |product|
    (product.price / 100).to_f
  end
end
