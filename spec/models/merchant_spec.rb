require 'rails_helper'
describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through :items }
    it { should have_many(:invoices).through :invoice_items }
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values({enable: 0, disable: 1})}
  end

  describe 'instance and class methods' do
    it '.enabled_merchants' do
      merchant_1 = Merchant.create!(name: 'merchant_1')
      merchant_2 = Merchant.create!(name: 'merchant_2', status: 0)
      merchant_3 = Merchant.create!(name: 'merchant_3')
      merchant_4 = Merchant.create!(name: 'merchant_4', status: 0)

      expect(Merchant.enabled_merchants).to eq([merchant_2, merchant_4])
    end

    it '.disabled_merchants' do
      merchant_1 = Merchant.create!(name: 'merchant_1')
      merchant_2 = Merchant.create!(name: 'merchant_2', status: 0)
      merchant_3 = Merchant.create!(name: 'merchant_3')
      merchant_4 = Merchant.create!(name: 'merchant_4', status: 0)

      expect(Merchant.disabled_merchants).to eq([merchant_1, merchant_3])
    end
  end

end
