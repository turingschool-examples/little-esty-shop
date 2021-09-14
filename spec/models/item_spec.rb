require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:unit_price) }
  end

  it "shows only enabled items" do
    @merchant = Merchant.create!(name: "Steve")
    @merchant_2 = Merchant.create!(name: "Kevin")
    @item_1 = @merchant.items.create!(name: "Lamp", description: "Sheds light", unit_price: 5, enable: 0)
    @item_2 = @merchant.items.create!(name: "Toy", description: "Played with", unit_price: 10, enable: 0)
    @item_3 = @merchant.items.create!(name: "Chair", description: "Sit on it", unit_price: 50)
    @item_4 = @merchant_2.items.create!(name: "Table", description: "Eat on it", unit_price: 100, enable: 0)

    expect(Item.enabled_items).to eq([@item_1, @item_2, @item_4])
  end

  it "shows only disabled items" do
    @merchant = Merchant.create!(name: "Steve")
    @merchant_2 = Merchant.create!(name: "Kevin")
    @item_1 = @merchant.items.create!(name: "Lamp", description: "Sheds light", unit_price: 5, enable: 0)
    @item_2 = @merchant.items.create!(name: "Toy", description: "Played with", unit_price: 10, enable: 0)
    @item_3 = @merchant.items.create!(name: "Chair", description: "Sit on it", unit_price: 50)
    @item_4 = @merchant_2.items.create!(name: "Table", description: "Eat on it", unit_price: 100, enable: 0)

    expect(Item.disabled_items).to eq([@item_3])
  end
end
