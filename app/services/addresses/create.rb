module Addresses
  class Create < BaseService
    def initialize(street:, number:, letter: nil, postal_code:, country:, city:)
      @street = street
      @number = number
      @letter = letter
      @postal_code = postal_code
      @country = country
      @city = city
    end

    def execute
      Address.create!(street: @street, number: @number, letter: @letter, postal_code: @postal_code, country: @country, city: @city)
    end
  end
end
