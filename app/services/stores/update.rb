module Stores
  class Update < BaseService
    def initialize(store:, name:, phone:, email: nil, street:, number:, letter: nil, postal_code:, country:, city:)
      @store = store
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
        @store.update!(name: @name, phone: @phone, email: @email)

        ::Addresses::Update.execute(address: @store.address, street: @street, number: @number, letter: @letter, postal_code: @postal_code, country: @country, city: @city)

        @store
      end
    end
  end
end
