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
      before :each do 

        @merchant= FactoryBot.create_list(:merchant, 3)

        @customer = FactoryBot.create_list(:customer, 2)

        @item = FactoryBot.create_list(:item, 25, merchant: @merchant[0])
        
        @item2 = FactoryBot.create_list(:item, 25, merchant: @merchant[1])

        @invoices = FactoryBot.create_list(:invoice, 2, customer: @customer[0])

        @invoices2 = FactoryBot.create_list(:invoice, 2, customer: @customer[1])

        @transactions= FactoryBot.create_list(:transaction, 5, invoice: @invoices[0])
      
        @transactions= FactoryBot.create_list(:transaction, 5, invoice: @invoices[1])

        @invoice_items_1 = FactoryBot.create_list(:invoice_item, 5, invoice: @invoices[1], item: @item[0])

        @invoice_items_2 = FactoryBot.create_list(:invoice_item, 5, invoice: @invoices[1], item: @item[1])

        @invoice_items_3 = FactoryBot.create_list(:invoice_item, 5, invoice: @invoices[1], item: @item[2])

      end

      it "selects the five most popular items" do 
        
        require 'pry'; binding.pry
        expect(merchant).to be_an_instance_of(Merchant)

        expect(Item.five_popular_items(merchant_id)).to be_an_instance_of(ActiveRecord::Relation)


      end
    end
  end
end
