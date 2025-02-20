require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should belong_to(:store) }
    it { should have_many(:order_products).dependent(:destroy) }
    it { should have_many(:products).through(:order_products) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(draft: 0, paid: 1, delivered: 2, cancelled: 3) }
  end

  describe 'callbacks' do
    it 'generates uuid before creation' do
      order = build(:order, uuid: nil)
      order.save
      expect(order.uuid).not_to be_nil
    end
  end

  describe 'state transitions' do
    let(:order) { create(:order, status: :draft) }

    describe '#pay' do
      it 'transitions from draft to paid' do
        expect(order.pay!).to be true
        expect(order.reload.status).to eq('paid')
      end
    end

    describe '#cancel' do
      it 'transitions from draft to cancelled' do
        expect(order.cancel!).to be true
        expect(order.reload.status).to eq('cancelled')
      end
    end
  end

  describe '#calculate_total_amount' do
    let(:store) { create(:store) }
    let(:product) { create(:product, price: 1000) }
    let(:order) { create(:order, store: store) }

    before do
      create(:store_product, store: store, product: product)
      create(:order_product, order: order, product: product, quantity: 2)
    end

    it 'calculates the total amount correctly' do
      ::Orders::CalculateTotalAmount.execute(order)
      expect(order.total_price).to eq(2000)
    end
  end
end 