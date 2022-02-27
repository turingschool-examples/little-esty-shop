require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  it "exists" do
    merchant = create(:merchant)
    expect(merchant).to be_a(Merchant)
    expect(merchant).to be_valid
  end

  describe 'class methods' do 
    it '::group_items_by_status(bool)' do
      merchant = Merchant.create!(name: "Joe Schmoe's Lil Shoppe")
      item = merchant.items.create!(name: "Plutonium", description: "Good ol' Plutonium brother! YEE YEE!", unit_price: 300, status: true)
      item_two = merchant.items.create!(name: "Uranium", description: "Boring Uranium-235", unit_price: 150)

      expect(merchant.group_items_by_status(true)).to eq([merchant.items.find(item.id)])
      expect(merchant.group_items_by_status(false)).to eq([merchant.items.find(item_two.id)])
    end
  end
end
