require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many :customers }
    it { should have_many :items }
  end

  describe 'instance methods' do
    before :each do

      @merchant = FactoryBot.create(:merchant)
      @item1 = FactoryBot.create(:item, merchant: @merchant)
      @item2 = FactoryBot.create(:item, merchant: @merchant)
      @item3 = FactoryBot.create(:item, merchant: @merchant)
      @item4 = FactoryBot.create(:item, merchant: @merchant)
      @item5 = FactoryBot.create(:item, merchant: @merchant)
      @item6 = FactoryBot.create(:item, merchant: @merchant)

      @invoice_item2 = FactoryBot.create(:invoice_item, item: @item2)
      @invoice_item3 = FactoryBot.create(:invoice_item, item: @item3)
      @invoice_item4 = FactoryBot.create(:invoice_item, item: @item4)
      @invoice_item5 = FactoryBot.create(:invoice_item, item: @item5)
      @invoice_item6 = FactoryBot.create(:invoice_item, item: @item6)
      @invoice_item7 = FactoryBot.create(:invoice_item, item: @item1)
      @invoice_item8 = FactoryBot.create(:invoice_item, item: @item2)
      @invoice_item9 = FactoryBot.create(:invoice_item, item: @item3)
      @invoice = FactoryBot.create(:invoice, merchant: @merchant, customer: Customer.first)
      @invoice_item1 = FactoryBot.create(:invoice_item, item: @item1, invoice: @invoice)

      @transactions = FactoryBot.create(:transaction, invoice: @invoice)
    end

    it 'can find all enabled items for a merchant' do
      @merchant1 = Merchant.create!(name: "Robert Heath")

      @item10 = Item.create!(name: "magic pen", description: "special", unit_price: 9.10, enabled: true, merchant_id: @merchant1.id)
      @item20 = Item.create!(name: "preposterous pencil", description: "big", unit_price: 8.50, enabled: true, merchant_id: @merchant1.id)
      @item30 = Item.create!(name: "fantastic fountain pen", description: "small", unit_price: 55.00, merchant_id: @merchant1.id)
      @item40 = Item.create!(name: "blue pencil", description: "blue", unit_price: 100.00, merchant_id: @merchant1.id)

      expect(@merchant1.enabled_items).to eq([@item10, @item20])
    end

    it 'can find all disabled items for a merchant' do
      @merchant1 = Merchant.create!(name: "Robert Heath")

      @item10 = Item.create!(name: "magic pen", description: "special", unit_price: 9.10, enabled: true, merchant_id: @merchant1.id)
      @item20 = Item.create!(name: "preposterous pencil", description: "big", unit_price: 8.50, enabled: true, merchant_id: @merchant1.id)
      @item30 = Item.create!(name: "fantastic fountain pen", description: "small", unit_price: 55.00, merchant_id: @merchant1.id)
      @item40 = Item.create!(name: "blue pencil", description: "blue", unit_price: 100.00, merchant_id: @merchant1.id)

      expect(@merchant1.disabled_items).to eq([@item30, @item40])
    end

    it 'can find top five items for a merchant' do

      expect(@merchant.top_five_items).to eq([@item1])
    end
  end
end
