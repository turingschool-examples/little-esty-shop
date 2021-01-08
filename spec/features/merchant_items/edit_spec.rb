require 'rails_helper'

RSpec.describe 'Merchant Item Edit page' do
  describe "when I click on 'Update This Item' on the show page" do
    before :each do
      @merchant1 = Merchant.create!(name: "Robert Heath")
      @merchant2 = Merchant.create!(name: "Adam Etzion")

      @item1 = Item.create!(name: "magic pen", description: "special", unit_price: 9.10, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "preposterous pencil", description: "big", unit_price: 8.50, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: "fantastic fountain pen", description: "small", unit_price: 55.00, merchant_id: @merchant1.id)

      @item4 = Item.create!(name: "pen of mundanity", description: "fine", unit_price: 55.00, merchant_id: @merchant2.id)
    end

    it 'takes me to the edit url' do

      visit "merchant/#{@merchant1.id}/items/#{@item1.id}"

      click_on "Update This Item"

      expect(current_path).to eq("merchant/#{@merchant1.id}/items/#{@item.id}/edit")
    end


  end
end
