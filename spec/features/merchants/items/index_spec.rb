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

    it "Next to each of the 5 most popular items, I see the date 
        with the most sales for that item. I also see the label 
        'Top selling date for was'" do
      @invoice_1.update(created_at: 1.day.ago)
      @invoice_2.update(created_at: 2.days.ago)
      @invoice_3.update(created_at: 3.days.ago)
      @invoice_4.update(created_at: 4.days.ago)
      @invoice_5.update(created_at: 5.days.ago)
      @invoice_6.update(created_at: 6.days.ago)
      @invoice_7.update(created_at: 7.days.ago)
      @invoice_8.update(created_at: 8.days.ago)
      @invoice_9.update(created_at: 9.days.ago)
      @invoice_10.update(created_at: 10.days.ago)
      @invoice_11.update(created_at: 11.days.ago)
      @invoice_12.update(created_at: 12.days.ago)
      @invoice_13.update(created_at: 13.days.ago)
      @invoice_14.update(created_at: 14.days.ago)
      @invoice_15.update(created_at: 15.days.ago)
      @invoice_16.update(created_at: 16.days.ago)
      @invoice_17.update(created_at: 17.days.ago)
      @invoice_18.update(created_at: 18.days.ago)
      @invoice_19.update(created_at: 19.days.ago)
      @invoice_20.update(created_at: 20.days.ago)
      @invoice_item_50.update(quantity: 10)
      visit merchant_items_path(@merchant_3)
          save_and_open_page
      within('#statistics') do
        expect(page).to have_content("Top day for Item 21 was 04/02/2023")
        expect(page).to have_content("Top day for Item 20 was 04/05/2023")
        expect(page).to have_content("Top day for Item 19 was 04/08/2023")
        expect(page).to have_content("Top day for Item 18 was 04/11/2023")
        expect(page).to have_content("Top day for Item 17 was 03/25/2023")
      end
    end
  end
end
