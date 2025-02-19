class AddressBlueprint < Blueprinter::Base
  identifier :uuid
  fields :street, :number, :letter, :postal_code, :country, :city
end
