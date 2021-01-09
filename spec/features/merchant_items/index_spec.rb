require 'rails_helper'

RSpec.describe "Merchant Items Index" do
  describe "when I visit the index page for a merchant's items" do
    before :each do
      @merchant1 = Merchant.create!(name: "Robert Heath")
      @merchant2 = Merchant.create!(name: "Adam Etzion")

      @item1 = Item.create!(name: "magic pen", description: "special", unit_price: 9.10, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "preposterous pencil", description: "big", unit_price: 8.50, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: "fantastic fountain pen", description: "small", unit_price: 55.00, merchant_id: @merchant1.id)

      @item4 = Item.create!(name: "pen of mundanity", description: "fine", unit_price: 55.00, merchant_id: @merchant2.id)
    end

    it "shows a list of the items for only that particular merchant" do

      visit "merchant/#{@merchant1.id}/items"

      expect(page).to have_link(@item1.name)
      expect(page).to have_link(@item2.name)
      expect(page).to have_link(@item3.name)
      expect(page).not_to have_content(@item4.name)
    end
  end

  describe 'each item should have an enable or a disable button' do
    before :each do
      @merchant1 = Merchant.create!(name: "Robert Heath")

      @item1 = Item.create!(name: "magic pen", description: "special", unit_price: 9.10, enabled: true, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "preposterous pencil", description: "big", unit_price: 8.50, enabled: true, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: "fantastic fountain pen", description: "small", unit_price: 55.00, merchant_id: @merchant1.id)
    end

    it 'has an enabled button for disabled items' do
      visit "merchant/#{@merchant1.id}/items"

      within("#item-#{@item3.id}") do
        expect(page).to have_button('Enable')
      end
    end

    it 'has a disable button for enabled items' do
      visit "merchant/#{@merchant1.id}/items"
      
      within("#item-#{@item1.id}") do
        expect(page).to have_button('Disable')
      end

      within("#item-#{@item2.id}") do
        expect(page).to have_button('Disable')
      end
    end
  end
end
