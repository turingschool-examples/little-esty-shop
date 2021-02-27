require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }  
  end

  describe "class methods" do
    describe "::active" do
      it "can show an item status as active if it has been enabled" do
        merchant = Merchant.create(name: "John's Jewelry")
        item1 = merchant.items.create(name: "Gold Ring", description: "14K Wedding Band",
                                      unit_price: 599.95, status: "Active")
        item2 = merchant.items.create(name: "Pearl Necklace", description: "Beautiful White Pearls",
                                      unit_price: 250.00, status: "Inactive")
        item3 = merchant.items.create(name: "Diamond Earrings", description: "Sparkly studs",
                                      unit_price: 300.00, status: "Active")

        expect(Item.active).to eq([item1, item3])
        expect(Item.active).to_not eq([item2])
      end
    end

    describe "::inactive" do
      it "can show an item status as inactive if it has been disabled" do
        merchant = Merchant.create(name: "John's Jewelry")
        item1 = merchant.items.create(name: "Gold Ring", description: "14K Wedding Band",
                                      unit_price: 599.95, status: "Active")
        item2 = merchant.items.create(name: "Pearl Necklace", description: "Beautiful White Pearls",
                                      unit_price: 250.00, status: "Inactive")
        item3 = merchant.items.create(name: "Diamond Earrings", description: "Sparkly studs",
                                      unit_price: 300.00, status: "Active")

        expect(Item.inactive).to eq([item2])
        expect(Item.inactive).to_not eq([item1, item3])
      end
    end
  end
end
