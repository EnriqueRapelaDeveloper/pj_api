require 'rails_helper'

RSpec.describe Store, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }

    describe 'email validation' do
      it 'accepts valid emails' do
        valid_emails = ['user@example.com', 'USER@foo.COM', 'A_US-ER@foo.bar.org']
        valid_emails.each do |email|
          store = build(:store, email: email)
          expect(store).to be_valid
        end
      end

      it 'rejects invalid emails' do
        invalid_emails = ['user@example,com', 'user_at_foo.org', 'user.name@example.']
        invalid_emails.each do |email|
          store = build(:store, email: email)
          expect(store).not_to be_valid
        end
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:address) }
  end

  describe 'callbacks' do
    it 'generates a UUID before creating' do
      store = build(:store)
      expect(store.uuid).to be_nil
      store.save
      expect(store.uuid).not_to be_nil
    end
  end
end 