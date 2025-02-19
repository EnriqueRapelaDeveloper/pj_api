class Address < ApplicationRecord
  has_one :store

  validates :street, :number, :postal_code, :country, :city, presence: true

  before_create :generate_uuid

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
