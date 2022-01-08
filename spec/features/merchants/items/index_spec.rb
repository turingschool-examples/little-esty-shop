require 'rails_helper'

RSpec.describe 'merchant item index page' do
  describe 'merchant show page' do
    before(:each) do
      @merchant_1 = Merchant.create!(name: "Parker")
      @merchant_2 = Merchant.create!(name: "Kerri")
      @item1 = @merchant_1.items.create!(name: "Small Thing", description: "Its a thing that is small.", unit_price: 400)
      @item2 = @merchant_1.items.create!(name: "Large Thing", description: "Its a thing that is large.", unit_price: 800)
      @item3 = @merchant_2.items.create!(name: "Medium Thing", description: "Its a thing that is medium.", unit_price: 600)
      visit "/merchants/#{@merchant_1.id}/items"
    end

    it 'shows each item name' do
      expect(page).to have_content("Small Thing")
      expect(page).to have_content("Large Thing")
    end

    it 'does not show items for any other merchant' do
      expect(page).to_not have_content("Medium Thing")
    end

    it 'the item name is a link to the merchant items show page' do
      click_link("#{@item1.name}")

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item1.id}")
    end
  end

  describe 'enable/disable button' do
    it 'has a button to enable/disable an item' do
      merch_1 = Merchant.create!(name: "Clothing Store")
      item_1 = merch_1.items.create!(name: "Sweater", description: "Red Sweater", unit_price: 40)
      item_2 = merch_1.items.create!(name: "Hat", description: "Beanie", unit_price: 20, status: 1)
      item_3 = merch_1.items.create!(name: "Shoes", description: "Running Shoes", unit_price: 80)

      visit "/merchants/#{merch_1.id}/items"

      within("#item-#{item_1.id}") do
        expect(item_1.status).to eq("disabled")

        first(:button, "Enable").click

        expect(page).to have_button("Disable")
        expect(current_path).to eq("/merchants/#{merch_1.id}/items")
        updated_item_1 = Item.find(item_1.id)
        expect(updated_item_1.status).to eq("enabled")
      end

      within("#item-#{item_2.id}") do
        expect(item_2.status).to eq("enabled")
        first(:button, "Disable").click

        expect(page).to have_button("Enable")
        expect(current_path).to eq("/merchants/#{merch_1.id}/items")
        updated_item_2 = Item.find(item_2.id)
        expect(updated_item_2.status).to eq("disabled")
      end
    end
  end
end
