require 'rails_helper'

RSpec.describe "Index page", type: :feature do
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

    it "displays only the items for the given merchant" do
      visit merchant_items_path(@merchant_1)

      expect(page).to have_content("Merchant_1's items")
      expect(page).to have_content("Item_1")
      expect(page).to have_content("Item_2")
      expect(page).to have_content("Item_3")

      expect(page).to have_no_content("Item_4")
      expect(page).to have_no_content("Item_5")
      expect(page).to have_no_content("Item_6")
      expect(page).to have_no_content("Item_7")
      expect(page).to have_no_content("Item_8")
      expect(page).to have_no_content("Item_9")
      expect(page).to have_no_content("Item_10")
    end

    it "item names are links to item show page" do
      visit merchant_items_path(@merchant_3)

      expect(page).to have_link(@item_7.name, href: "/merchants/#{@merchant_3.id}/items/#{@item_7.id}")
      expect(page).to have_link(@item_8.name, href: "/merchants/#{@merchant_3.id}/items/#{@item_8.id}")
      expect(page).to have_link(@item_9.name, href: "/merchants/#{@merchant_3.id}/items/#{@item_9.id}")
      expect(page).to have_link(@item_10.name, href: "/merchants/#{@merchant_3.id}/items/#{@item_10.id}")

      click_link("Item_7")
      expect(page).to have_content("Item_7")
      expect(page).to have_content("Description: Description_7")
      expect(page).to have_content("Unit price: 700")
    end
  end

  describe "functionality" do
    before do
      @merchant_1 = FactoryBot.create(:merchant)
      @item_1 = FactoryBot.create(:item, merchant: @merchant_1)
      @item_2 = FactoryBot.create(:item, merchant: @merchant_1)
      @item_3 = FactoryBot.create(:item, merchant: @merchant_1)
      @item_4 = FactoryBot.create(:item, merchant: @merchant_1)
      @item_5 = FactoryBot.create(:item, merchant: @merchant_1)
    end

    it "has enable/disable buttons" do
      visit merchant_items_path(@merchant_1)
      
      expect(page.all(:button, "Enable").count).to eq(5)
      expect(page).to_not have_button("Disable")
    end

    it "disable button changes item status" do
      visit merchant_items_path(@merchant_1)

      expect(@item_1.status).to eq("disabled")

      click_button "enable_#{@item_1.id}"
      expect(current_path).to eq(merchant_items_path(@merchant_1))
      
      expect(page.all(:button, "Enable").count).to eq(4)
      expect(page).to have_button("Disable")
      @item_1.reload
      
      expect(@item_1.status).to eq("enabled")
    end
  end
  describe "Items grouped by status" do
    before do 
      @merchant_1 = FactoryBot.create(:merchant)
      @item_1 = FactoryBot.create(:item, merchant: @merchant_1)
      @item_2 = FactoryBot.create(:item, merchant: @merchant_1)
      @item_3 = FactoryBot.create(:item, merchant: @merchant_1)
      @item_4 = FactoryBot.create(:item, merchant: @merchant_1, status: 1)
      @item_5 = FactoryBot.create(:item, merchant: @merchant_1, status: 1)
    end
    it "displays a section for 'Enabled Items' and 'Disabled Items'" do
      visit merchant_items_path(@merchant_1)

      expect(page).to have_content("Enabled Items")
      expect(page).to have_content("Disabled Items")
    end

    it "displays all enabled items in the 'Enabled Items' section" do
      visit merchant_items_path(@merchant_1)

      within "#enabled-items" do
        expect(page).to have_content(@item_4.name)
        expect(page).to have_content(@item_5.name)

      end
    end

    it "displays all disabled items in the 'Disabled Items' section" do
      visit merchant_items_path(@merchant_1)

      within "#disabled-items" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_3.name)
      end
    end
  end

  describe "statistics" do
    before do
      test_data
    end

    it "5 most popular items" do
      visit merchant_items_path(@merchant_3)  

      within('#statistics') do
        expect(page).to have_content("Top 5 items")

        expect(page).to have_link(@item_21.name, href: merchant_item_path(@merchant_3, @item_21))
        expect(page).to have_content("Total revenue: 6300")
        expect(page).to have_link(@item_20.name, href: merchant_item_path(@merchant_3, @item_20))
        expect(page).to have_content("Total revenue: 6000")
        expect(page).to have_link(@item_19.name, href: merchant_item_path(@merchant_3, @item_19))
        expect(page).to have_content("Total revenue: 5700")
        expect(page).to have_link(@item_18.name, href: merchant_item_path(@merchant_3, @item_18))
        expect(page).to have_content("Total revenue: 5400")
        expect(page).to have_link(@item_17.name, href: merchant_item_path(@merchant_3, @item_17))
        expect(page).to have_content("Total revenue: 5100")
      end
    end
  end
end
