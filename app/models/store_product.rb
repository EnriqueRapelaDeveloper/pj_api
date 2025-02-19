class StoreProduct < ApplicationRecord
  belongs_to :store
  belongs_to :product

  validates :store_id,
            uniqueness: {
              scope: :product_id,
              message: 'Ya existe este producto en la tienda'
            }
end
