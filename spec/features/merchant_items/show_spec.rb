require 'rails_helper'

RSpec.describe "Item Show Page" do
  describe "when I visit the index page for a merchant's item" do
    before :each do
      @merchant1 = Merchant.create!(name: "Robert Heath")
      @merchant2 = Merchant.create!(name: "Adam Etzion")

      @item1 = Item.create!(name: "magic pen", description: "special", unit_price: 9.10, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "preposterous pencil", description: "big", unit_price: 8.50, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: "fantastic fountain pen", description: "small", unit_price: 55.00, merchant_id: @merchant1.id)

      @item4 = Item.create!(name: "pen of mundanity", description: "fine", unit_price: 55.00, merchant_id: @merchant2.id)
    end

    it 'can take me to a show page for a merchant item' do

        visit "merchant/#{@merchant1.id}/items"

        click_link "#{@item1.name}"

        expect(current_path).to eq("/merchant/#{@merchant1.id}/items/#{@item1.id}")
    end

    it 'shows the name, description, and current selling price' do

      visit "merchant/#{@merchant1.id}/items"

      click_link "#{@item1.name}"

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.description)
      expect(page).to have_content(@item1.unit_price)
    end
  end
end
