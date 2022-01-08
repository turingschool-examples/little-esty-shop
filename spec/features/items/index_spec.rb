require 'rails_helper'

describe 'merchants items index' do
  before do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Long Hair Dont Care')

    @item1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant2.id)

    visit merchant_items_path(@merchant1)
  end

  describe 'display' do
    it 'all items from this merchant' do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to_not have_content(@item3.name)
    end

    it 'every item name is a link to its show page' do
      click_link(@item1.name)
      expect(current_path).to eq(merchant_item_path(@merchant1, @item1))
    end

    it 'has a link to create a new item' do
      click_link "Create New Item"

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/new")
    end

    it 'has a button to enable or disable next to each item name' do
      within("#item-#{@item1.id}") do
        expect(@item1.status).to eq("Disabled")
      end
      within("#item-#{@item1.id}") do
        click_button "Enable this item"
        expect(current_path).to eq(merchant_items_path(@merchant1))
        expect(@item1.status).to eq("Enabled")
      end
    end
  end
end
