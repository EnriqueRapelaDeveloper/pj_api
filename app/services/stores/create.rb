module Stores
  class Create < BaseService
    def initialize(name:, phone:, email: nil, street:, number:, letter: nil, postal_code:, country:, city:)
      @name = name
      @phone = phone
      @email = email
      @street = street
      @number = number
      @letter = letter
      @postal_code = postal_code
      @country = country
      @city = city
    end

    def execute
      Store.transaction do
        address = ::Addresses::Create.execute(street: @street, number: @number, letter: @letter, postal_code: @postal_code, country: @country, city: @city)
        Store.create!(name: @name, phone: @phone, email: @email, address: address)
      end
    end
  end
end
