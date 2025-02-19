class Order < ApplicationRecord
  include AASM
  belongs_to :store
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  validates :status, presence: true

  enum status: { draft: 0, paid: 1, delivered: 2, cancelled: 3 }

  aasm column: 'status', enum: true do
    state :draft, initial: true
    state :paid
    state :delivered
    state :cancelled

    event :pay do
      transitions from: :draft, to: :paid
    end

    event :deliver do
      transitions from: :paid, to: :delivered
    end

    event :cancel do
      transitions from: [:draft, :paid], to: :cancelled
    end
  end

  before_create :generate_uuid

  private

  def total_price_is_positive?
    total_price.positive?
  end

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
