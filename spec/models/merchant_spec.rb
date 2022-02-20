require 'rails_helper'

RSpec.describe Merchant do
  describe 'relations' do
    it {should have_many(:items)}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:customers).through(:invoices)}
  end

  describe 'class methods' do
    before :each do
      @merchant_1 = Merchant.create!(name: "LT's Tee Shirts LLC", status: 0)
      @merchant_2 = Merchant.create!(name: 'Handmade in CO Co.', status: 1)
      @merchant_3 = Merchant.create!(name: 'Happy Crafts', status: 1)
      @merchant_4 = Merchant.create!(name: 'Not-So-Happy Crafts')

      visit "/admin/merchants"
    end

    it 'returns all merchants with a status of disabled' do
      expect(Merchant.disabled).to eq([@merchant_1, @merchant_4])
    end

    it 'returns all merchants with a status of enabled' do
      expect(Merchant.enabled).to eq([@merchant_2, @merchant_3])
    end
  end
end
