class Product < ApplicationRecord
  enum kind: {
    pizza: 0,
    complement: 1
  }

  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :name, :sku, :description, presence: true
  validates :sku, uniqueness: true

  before_create :generate_uuid

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
