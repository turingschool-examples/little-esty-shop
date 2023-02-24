require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to :merchant }
  it { should have_many :invoice_items }
  it { should have_many(:customers).through(:invoices) }

  describe "#class methods" do 
    describe "handwritten test data" do 
    before(:each) do 
    @merchant1 = Merchant.create!(name: "Hady", uuid: 1) 
    @merchant2 = Merchant.create!(name: "Malena", uuid: 2) 
  
    @item_1 = @merchant1.items.create(name: "Salt", description: "it is salty", unit_price: 12, uuid: 1)
    @item_2 = @merchant1.items.create(name: "Pepper", description: "it is peppery", unit_price: 11, uuid: 2)
    @item_3 = @merchant2.items.create(name: "Spices", description: "it is spicy", unit_price: 13, uuid: 3)
    @item_4 = @merchant2.items.create(name: "Sand", description: "its all over the place", unit_price: 14, status: 1, uuid: 4)
    @item_5 = @merchant1.items.create(name: "Water", description: "nice and liquidy", unit_price: 15, status: 1, uuid: 5)
    end 

    it "self.disabled status items" do 
      params = {"controller"=>"merchants/items", "action"=>"index", :merchant_id=>"#{@merchant1.id}"}
      expect(Item.disabled_status_items(params)).to eq([@item_1, @item_2])
    end

    it "enabled status items" do 
      params = {"controller"=>"merchants/items", "action"=>"index", :merchant_id=>"#{@merchant1.id}"}
      expect(Item.enabled_status_items(params)).to eq([@item_5])
    end
  end 

    describe "factory bot and faker methods" do 
      it "selects the five most popular items" do 
        @merchant= FactoryBot.create_list(:merchant, 2)
        @customer = FactoryBot.create(:customer)
        @item = FactoryBot.create_list(:item, 15, merchant: @merchant[0])
        @invoices = FactoryBot.create_list(:invoice, 2, customer: @customer)
        @transactions= FactoryBot.create_list(:transaction, 1, invoice: @invoices[0], result: 0)
        @transactions_2= FactoryBot.create_list(:transaction, 1, invoice: @invoices[1], result: 1)
        @invoice_items_1 = FactoryBot.create(:invoice_item, invoice: @invoices[0], item: @item[0], unit_price: 1, quantity: 1)
        @invoice_items_2 = FactoryBot.create(:invoice_item, invoice: @invoices[1], item: @item[12], unit_price: 2, quantity: 1)
        @invoice_items_3 = FactoryBot.create(:invoice_item, invoice: @invoices[0], item: @item[1], unit_price: 3, quantity: 1)
        @invoice_items_4 = FactoryBot.create(:invoice_item, invoice: @invoices[0], item: @item[2], unit_price: 4, quantity: 1)      
        @invoice_items_5 = FactoryBot.create(:invoice_item, invoice: @invoices[0], item: @item[3], unit_price: 5, quantity: 1)
        @invoice_items_6 = FactoryBot.create(:invoice_item, invoice: @invoices[0], item: @item[4], unit_price: 6, quantity: 1)
        @invoice_items_7 = FactoryBot.create(:invoice_item, invoice: @invoices[0], item: @item[5], unit_price: 7, quantity: 1) 
        @invoice_items_9 = FactoryBot.create(:invoice_item, invoice: @invoices[0], item: @item[7], unit_price: 8, quantity: 1)
        @invoice_items_10 = FactoryBot.create(:invoice_item, invoice: @invoices[0], item: @item[8], unit_price: 9, quantity: 1)
        @invoice_items_11 = FactoryBot.create(:invoice_item, invoice: @invoices[0], item: @item[9], unit_price: 10, quantity: 1)
        @invoice_items_12 = FactoryBot.create(:invoice_item, invoice: @invoices[0], item: @item[10], unit_price: 11, quantity: 1)
        @invoice_items_14 = FactoryBot.create(:invoice_item, invoice: @invoices[0], item: @item[3], unit_price: 9, quantity: 1)
        @invoice_items_11 = FactoryBot.create(:invoice_item, invoice: @invoices[0], item: @item[9], unit_price: 1, quantity: 7)

        expect(Item.five_popular_items(@merchant[0])).to eq([@item[9], @item[3], @item[10], @item[8], @item[7]])

      end
    end
  end
end
