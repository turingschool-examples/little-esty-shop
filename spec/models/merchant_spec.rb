require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:customers).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end

  before :each do 
    @merchant_1 = Merchant.create!(name: 'Schroeder-Jerde', status: :disabled)
    @merchant_2 = Merchant.create!(name: 'Rempel and Jones', status: :enabled)
    @merchant_3 = Merchant.create!(name: 'Willms and Sons', status: :disabled)
  end

  describe 'model methods' do 
    it '#find_by_status' do 
      enabled_merchants = Merchant.find_by_status('enabled')
      expect(enabled_merchants.to_a).to eq([@merchant_2])

      disabled_merchants = Merchant.find_by_status('disabled')
      expect(disabled_merchants.to_a).to eq([@merchant_3, @merchant_1])
    end
  end
end