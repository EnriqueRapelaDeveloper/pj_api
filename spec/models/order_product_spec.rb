require 'rails_helper'

RSpec.describe OrderProduct, type: :model do
  describe 'associations' do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
  end

  describe 'callbacks' do
    let(:store) { create(:store) }
    let(:product) { create(:product, price: 1000) }
    let(:order) { create(:order, store: store) }

    before do
      create(:store_product, store: store, product: product)
    end

    it 'updates order total_price after creation' do
      order_product = create(:order_product, order: order, product: product, quantity: 2)
      ::Orders::CalculateTotalAmount.execute(order)
      expect(order.reload.total_price).to eq(product.price * 2)
    end

    it 'updates order total_price after updating quantity' do
      order_product = create(:order_product, order: order, product: product, quantity: 2)
      order_product.update(quantity: 3)
      ::Orders::CalculateTotalAmount.execute(order)
      expect(order.reload.total_price).to eq(product.price * 3)
    end
  end
end 