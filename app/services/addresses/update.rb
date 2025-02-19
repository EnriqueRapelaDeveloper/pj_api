module Addresses
  class Update < BaseService
    def initialize(address:, street:, number:, letter: nil, postal_code:, country:, city:)
      @address = address
      @street = street
      @number = number
      @letter = letter
      @postal_code = postal_code
      @country = country
      @city = city
    end

    def execute
      @address.update!(street: @street, number: @number, letter: @letter, postal_code: @postal_code, country: @country, city: @city)
      @address
    end
  end
end
