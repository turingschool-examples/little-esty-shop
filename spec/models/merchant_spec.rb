require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}

  end

  describe 'instance methods' do
    before(:each) do
      @billman = Merchant.create!(name: "Billman")

      @bracelet = @billman.items.create!(name: "Bracelet", description: "shiny", unit_price: 1001)
      @mood = @billman.items.create!(name: "Mood Ring", description: "Moody", unit_price: 2002)

      @brenda = Customer.create!(first_name: "Brenda", last_name: "Bhoddavista")

      @invoice1 = @brenda.invoices.create!(status: "In Progress")
      @invoice2 = @brenda.invoices.create!(status: "Completed")

      @order1 = @bracelet.invoice_items.create!(quantity: 1, unit_price: 1001, status: "Pending", invoice_id: @invoice1.id)
      @order2 = @mood.invoice_items.create!(quantity: 1, unit_price: 2002, status: "Packaged", invoice_id: @invoice1.id)
      @order3 = @mood.invoice_items.create!(quantity: 3, unit_price: 2002, status: "Shipped", invoice_id: @invoice2.id)
    end
    it 'returns an array of items that are not shipped' do
      expect(@billman.items_to_ship[0].name).to eq("Bracelet")
      expect(@billman.items_to_ship[1].name).to eq("Mood Ring")
      expect(@billman.items_to_ship[0].invoice_id).to eq(@invoice1.id)
      expect(@billman.items_to_ship[1].invoice_id).to eq(@invoice1.id)
      expect(@billman.items_to_ship.pluck(:name)).to eq(["Bracelet", "Mood Ring"])
      expect(@billman.items_to_ship.pluck(:invoice_id)).to eq([@invoice1.id, @invoice1.id])
      expect(@billman.items_to_ship.pluck(:invoice_id)).to_not eq([@invoice2.id])
    end
  end

  describe "class methods" do
    before(:each) do
      @billman = Merchant.create!(name: "Billman")

      @bracelet = @billman.items.create!(name: "Bracelet", description: "shiny", unit_price: 1001, status: "disabled")
      @mood = @billman.items.create!(name: "Mood Ring", description: "Moody", unit_price: 2002)
      @necklace = @billman.items.create!(name: "Necklace", description: "Sparkly", unit_price: 3045, status: "disabled")
      @toe_ring = @billman.items.create!(name: "Toe Ring", description: "Saucy", unit_price: 1053)
    end

    it "can sort items by their status" do
      expect(@billman.enabled_items).to eq([@mood, @toe_ring])
      expect(@billman.disabled_items).to eq([@bracelet, @necklace])
    end
  end
end
