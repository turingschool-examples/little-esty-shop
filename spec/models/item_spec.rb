require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to :merchant }
  it { should have_many :invoice_items }
  it { should have_many(:customers).through(:invoices) }

  describe "#class methods" do 
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


end
