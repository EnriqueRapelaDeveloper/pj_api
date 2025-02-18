class StoreBlueprint < Blueprinter::Base
  identifier :uuid
  fields :name, :phone, :email, :created_at

  association :address, blueprint: AddressBlueprint
end
