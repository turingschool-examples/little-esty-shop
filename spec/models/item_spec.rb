require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:customers).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_numericality_of(:unit_price)}
  end

  it 'has a method to toggle item status' do
    item = Item.new(name: "item test", description: "this is a test item", unit_price: 4, status: "Disabled")
    item.toggle_status
    expect(item.status).to eq("Enabled")

    item.toggle_status
    expect(item.status).to eq("Disabled")
  end

  it 'has a method to find all instances of itself associated with a certain merchant and status' do
    merchant = Merchant.create!(name: "Test Merchant")
    item1 = Item.create!(name: "item test", description: "this is a test item", unit_price: 4, status: "Disabled", merchant_id: merchant.id)
    item2 = Item.create!(name: "item test", description: "this is a test item", unit_price: 4, status: "Disabled", merchant_id: merchant.id)
    item3 = Item.create!(name: "item test", description: "this is a test item", unit_price: 4, status: "Enabled", merchant_id: merchant.id)
    item4 = Item.create!(name: "item test", description: "this is a test item", unit_price: 4, status: "Enabled", merchant_id: merchant.id)

    expect(Item.find_merchant_items_by_status(merchant.id, "Enabled")).to eq([item3, item4])
    expect(Item.find_merchant_items_by_status(merchant.id, "Disabled")).to eq([item1, item2])
  end

end