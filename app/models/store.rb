class Store < ApplicationRecord
  has_many :store_products
  has_many :products, through: :store_products

  belongs_to :address

  validates :name, :phone, :address, presence: true

  before_create :generate_uuid
  before_validation :set_default_email

  validates :name, uniqueness: { scope: [:phone], message: "Ya existe una tienda con el mismo nombre y teléfono" }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "El correo electrónico no es válido" }

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def set_default_email
    self.email ||= "kevin.fernandez@pjchile.com"
  end
end
