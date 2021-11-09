require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it {should have_many :invoice_items}
    it {should belong_to :merchant}
  end

  describe "::find_item" do
    it 'can find an item by id' do
      merchant1 = Merchant.create!(name: "Bob's Burgers")
      item1 = Item.create!(name: "Burger", description: "Burger with fries", unit_price: 3, merchant_id: merchant1.id)

      expect(Item.find_item(item1.id)).to eq(item1)
    end
  end
end
