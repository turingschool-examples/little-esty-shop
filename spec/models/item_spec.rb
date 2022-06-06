require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
  end
  
  describe "class methods" do
    before(:each) do
      @billman = Merchant.create!(name: "Billman")

      @bracelet = @billman.items.create!(name: "Bracelet", description: "shiny", unit_price: 1001, status: "disabled")
      @mood = @billman.items.create!(name: "Mood Ring", description: "Moody", unit_price: 2002)
      @necklace = @billman.items.create!(name: "Necklace", description: "Sparkly", unit_price: 3045, status: "disabled")
      @toe_ring = @billman.items.create!(name: "Toe Ring", description: "Saucy", unit_price: 1053)
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
