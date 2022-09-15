require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :status }
    it { should define_enum_for(:status).with_values(["Enabled", "Disabled"])}
  end

  describe 'relationships' do
    it { should have_many :items}
  end

  describe 'class methods' do
    describe '#enabled_merchants' do
      it 'sorts merchants by if their status is enabled' do
        merch1 = Merchant.create!(name: Faker::Movies::VForVendetta.character, status: 0)
        merch2 = Merchant.create!(name: Faker::Movies::VForVendetta.character, status: 1)
        merch3 = Merchant.create!(name: Faker::Movies::VForVendetta.character, status: 0)
        merch4 = Merchant.create!(name: Faker::Movies::VForVendetta.character, status: 1)
        merch5 = Merchant.create!(name: Faker::Movies::VForVendetta.character, status: 0)

        enabled_merchants = [merch1, merch3, merch5]

        expect(Merchant.enabled_merchants).to eq(enabled_merchants)
      end
    end

    describe '#disabled_merchants' do
      it 'sorts merchants by if their status is disabled' do
        merch1 = Merchant.create!(name: Faker::Movies::VForVendetta.character, status: 0)
        merch2 = Merchant.create!(name: Faker::Movies::VForVendetta.character, status: 1)
        merch3 = Merchant.create!(name: Faker::Movies::VForVendetta.character, status: 0)
        merch4 = Merchant.create!(name: Faker::Movies::VForVendetta.character, status: 1)
        merch5 = Merchant.create!(name: Faker::Movies::VForVendetta.character, status: 0)

        disabled_merchants = [merch2, merch4]

        expect(Merchant.disabled_merchants).to eq(disabled_merchants)
      end
    end
  end
end