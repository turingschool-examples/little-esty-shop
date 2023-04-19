require 'rails_helper'

RSpec.describe "Item show page", type: :feature do
  describe "display" do
    before do
      @merchant_1 = Merchant.create!(name: "Merchant_1")
      @merchant_2 = Merchant.create!(name: "Merchant_2")
      @merchant_3 = Merchant.create!(name: "Merchant_3")
      @item_1 = @merchant_1.items.create!(name: "Item_1", description: "Description_1", unit_price: 100)
      @item_2 = @merchant_1.items.create!(name: "Item_2", description: "Description_2", unit_price: 200)
      @item_3 = @merchant_1.items.create!(name: "Item_3", description: "Description_3", unit_price: 300)
      @item_4 = @merchant_2.items.create!(name: "Item_4", description: "Description_4", unit_price: 400)
      @item_5 = @merchant_2.items.create!(name: "Item_5", description: "Description_5", unit_price: 500)
      @item_6 = @merchant_2.items.create!(name: "Item_6", description: "Description_6", unit_price: 600)
      @item_7 = @merchant_3.items.create!(name: "Item_7", description: "Description_7", unit_price: 700)
      @item_8 = @merchant_3.items.create!(name: "Item_8", description: "Description_8", unit_price: 800)
      @item_9 = @merchant_3.items.create!(name: "Item_9", description: "Description_9", unit_price: 900)
      @item_10 = @merchant_3.items.create!(name: "Item_10", description: "Description_10", unit_price: 1000)
      @item_11 = FactoryBot.create(:item, merchant: @merchant_1)
    end
    
    it "visit item show page, see a link to update that item" do
      visit merchant_item_path(@merchant_2, @item_4)
      save_and_open_page

      expect(page).to have_link("Update #{@item_4.name}", href: "/merchants/#{@merchant_2.id}/items/#{@item_4.id}/edit")

      click_link ("Update Item_4")

      expect(current_path).to eq("/merchants/#{@merchant_2.id}/items/#{@item_4.id}/edit")

      expect(page).to have_field("Name", with: "Item_4")
      expect(page).to have_field("Unit Price", with: "400")
      expect(page).to have_field("Description", with: "Description_4")
      expect(page).to have_button("Update Item")

      fill_in "Name", with: "Cookies"      
      fill_in "Unit Price", with: "750"      
      fill_in "Description", with: "Yummy"      

      click_button ("Update Item")

      expect(current_path).to eq("/merchants/#{@merchant_2.id}/items/#{@item_4.id}")
      expect(page).to have_content("Cookies")
      expect(page).to have_content("Description: Yummy")
      expect(page).to have_content("Unit price: 750")
   
    end
    it "visit item show page, see a link to update that item" do
      visit merchant_item_path(@merchant_2, @item_4)

      expect(page).to have_link("Update #{@item_4.name}", href: "/merchants/#{@merchant_2.id}/items/#{@item_4.id}/edit")

      click_link ("Update Item_4")

      expect(current_path).to eq("/merchants/#{@merchant_2.id}/items/#{@item_4.id}/edit")

      expect(page).to have_field("Name", with: "Item_4")
      expect(page).to have_field("Unit Price", with: "400")
      expect(page).to have_field("Description", with: "Description_4")
      expect(page).to have_button("Update Item")

      fill_in "Name", with: "Cookies"      
      fill_in "Unit Price", with: "750"      
      fill_in "Description", with: "Yummy"      

      click_button ("Update Item")

      expect(current_path).to eq("/merchants/#{@merchant_2.id}/items/#{@item_4.id}")
      expect(page).to have_content("Cookies")
      expect(page).to have_content("Description: Yummy")
      expect(page).to have_content("Unit price: 750")
    end
  end
end