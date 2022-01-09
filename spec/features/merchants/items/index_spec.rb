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

  describe '5 most popular items ranked' do
    before(:each) do
      @merch_1 = Merchant.create!(name: "Cat Stuff")
      @merch_2 = Merchant.create!(name: "Dog Stuff")

      @cust1 = FactoryBot.create(:customer)
      @cust2 = FactoryBot.create(:customer)
      @cust3 = FactoryBot.create(:customer)

      @inv1 = @cust1.invoices.create!(status: 1)
      @tran1 = FactoryBot.create(:transaction, invoice: @inv1,  result: 1)
      @tran2 = FactoryBot.create(:transaction, invoice: @inv1,  result: 1)

      @inv2 = @cust1.invoices.create!(status: 1)
      @tran3 = FactoryBot.create(:transaction, invoice: @inv2,  result: 1)
      @tran4 = FactoryBot.create(:transaction, invoice: @inv2,  result: 1)

      @inv3 = @cust2.invoices.create!(status: 1)
      @tran7 = FactoryBot.create(:transaction, invoice: @inv3,  result: 1)

      @inv4 = @cust2.invoices.create!(status: 1)
      @tran8 = FactoryBot.create(:transaction, invoice: @inv4,  result: 1)

      @inv5 = @cust3.invoices.create!(status: 1)
      @tran9 = FactoryBot.create(:transaction, invoice: @inv5,  result: 1)

      @inv6 = @cust3.invoices.create!(status: 0)
      @tran10 = FactoryBot.create(:transaction, invoice: @inv6,  result: 1)

      @inv7 = @cust3.invoices.create!(status: 1)
      @tran11 = FactoryBot.create(:transaction, invoice: @inv7,  result: 0)

      @inv8 = @cust3.invoices.create!(status: 0)
      @tran12 = FactoryBot.create(:transaction, invoice: @inv8,  result: 0)

      @item1 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 100)
      @item2 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 200)
      @item3 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 300)
      @item4 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 400)
      @item5 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 500)
      @item6 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 600)
      @item7 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 700)
      @item8 = FactoryBot.create(:item, merchant: @merch_2, unit_price: 10000)

      @ii_1 = InvoiceItem.create!(invoice: @inv1, item: @item7, quantity: 20, unit_price: 700, status: "pending")
      #14000
      @ii_2 = InvoiceItem.create!(invoice: @inv1, item: @item5, quantity: 10, unit_price: 500, status: "pending")
      #5000
      @ii_3 = InvoiceItem.create!(invoice: @inv2, item: @item7, quantity: 20, unit_price: 700, status: "pending")
      #14000
      @ii_4 = InvoiceItem.create!(invoice: @inv2, item: @item5, quantity: 10, unit_price: 500, status: "pending")
      #5000
      @ii_4 = InvoiceItem.create!(invoice: @inv2, item: @item1, quantity: 30, unit_price: 100, status: "pending")
      #3000
      @ii_5 = InvoiceItem.create!(invoice: @inv3, item: @item4, quantity: 3, unit_price: 400, status: "pending")
      #1200
      @ii_6 = InvoiceItem.create!(invoice: @inv3, item: @item1, quantity: 30, unit_price: 100, status: "pending")
      #3000
      @ii_7 = InvoiceItem.create!(invoice: @inv3, item: @item2, quantity: 5, unit_price: 200, status: "pending")
      #1000 - Item2 won't be in top 5
      @ii_8 = InvoiceItem.create!(invoice: @inv4, item: @item3, quantity: 5, unit_price: 300, status: "pending")
      #1500
      @ii_9 = InvoiceItem.create!(invoice: @inv5, item: @item3, quantity: 5, unit_price: 300, status: "pending")
      #1500
      @ii_10 = InvoiceItem.create!(invoice: @inv5, item: @item6, quantity: 1, unit_price: 600, status: "pending")
      #600 - Item6 won't be in top 5

      @ii_11 = InvoiceItem.create!(invoice: @inv6, item: @item6, quantity: 2000, unit_price: 600, status: "pending")
      @ii_12 = InvoiceItem.create!(invoice: @inv7, item: @item6, quantity: 2000, unit_price: 600, status: "pending")
      @ii_13 = InvoiceItem.create!(invoice: @inv8, item: @item6, quantity: 2000, unit_price: 600, status: "pending")
      @ii_14 = InvoiceItem.create!(invoice: @inv8, item: @item8, quantity: 2000, unit_price: 10000, status: "pending")
    end

    it 'shows the names of the 5 most popular ITEMS ranked by total revenue generated' do
      visit "/merchants/#{@merch_1.id}/items"

      within("#top-items") do
        expect(page).to have_content(@item7.name)
        expect(page).to have_content(@item5.name)
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item3.name)
        expect(page).to have_content(@item4.name)
        expect(@item7.name).to appear_before(@item5.name)
        expect(@item5.name).to appear_before(@item1.name)
        expect(@item1.name).to appear_before(@item3.name)
        expect(@item3.name).to appear_before(@item4.name)
        expect(page).to_not have_content(@item8.name)
      end
    end

    it 'each of the top 5 items links to the item show page' do
      visit "/merchants/#{@merch_1.id}/items"

      within("#top-items") do
        expect(page).to have_link("#{@item7.name}")
        expect(page).to have_link("#{@item5.name}")
        expect(page).to have_link("#{@item1.name}")
        expect(page).to have_link("#{@item3.name}")
        expect(page).to have_link("#{@item4.name}")
        expect(page).to_not have_link("#{@item8.name}")

        click_link("#{@item7.name}")

        expect(current_path).to eq("/merchants/#{@merch_1.id}/items/#{@item7.id}")
      end 
    end

    xit 'each of the top 5 items shows its total revenue' do
      # And I see the total revenue generated next to each item name
    end
  end
end
