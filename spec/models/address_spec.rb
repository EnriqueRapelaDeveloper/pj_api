require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:postal_code) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:city) }
  end

  describe 'associations' do
    it { should have_one(:store) }
  end

  describe 'callbacks' do
    it 'generates a UUID before creating' do
      address = build(:address)
      expect(address.uuid).to be_nil
      address.save
      expect(address.uuid).not_to be_nil
    end
  end
end 