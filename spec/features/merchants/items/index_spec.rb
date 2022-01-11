require 'rails_helper'

RSpec.describe 'Merchant Items Index page' do

  it 'shows a list of the names of all of my items and no other merchants items' do
    merchant = create(:merchant)
    item1 = create(:item, merchant: merchant, name: "Paul")
    item2 = create(:item, merchant: merchant, name: "Leland")
    item3 = create(:item, name: "Eric")

    visit "/merchants/#{merchant.id}/items"
    expect(page).to have_content("Paul")
    expect(page).to have_content("Leland")
    expect(page).to_not have_content('Eric')
  end

  it "Has button next to each item to enable. Buttons refreshes the page with updated enabled status" do
    merchant = create(:merchant)
    item1 = create(:item, merchant: merchant, name: "Paul")
    item2 = create(:item, merchant: merchant, name: "Leland")
    visit "/merchants/#{merchant.id}/items"
    within("div.item_#{item2.id}") do
      expect(page).to have_button("Enable")

      click_button("Enable")

      expect(current_path).to eq("/merchants/#{merchant.id}/items")

      item2.reload
      expect(item2.status).to eq("Enabled")
    end
  end

  it "Has button next to each item to disable. Buttons refreshes the page with updated disabled status" do
    merchant = create(:merchant)
    item1 = create(:item, merchant: merchant, name: "Paul")
    item2 = create(:item, merchant: merchant, name: "Leland", status: "Enabled")
    visit "/merchants/#{merchant.id}/items"
    within("div.item_#{item2.id}") do
      expect(page).to have_button("Disable")

      click_button("Disable")

      expect(current_path).to eq("/merchants/#{merchant.id}/items")

      item2.reload
      expect(item2.status).to eq("Disabled")
    end
  end

  it "has a link to create a new item" do
    merchant = create(:merchant)

    visit "/merchants/#{merchant.id}/items"

    click_link("Create New Item")

    expect(current_path).to eq("/merchants/#{merchant.id}/items/new")
  end

  it "has two sections, one for enabled items, and one for disabled items. Items are separated to these sections based on status" do
    merchant = create(:merchant)
    item1 = create(:item, merchant: merchant, name: "Paul")
    item2 = create(:item, merchant: merchant, name: "Leland")
    item3 = create(:item, merchant: merchant, name: "Josh", status: 1)
    visit "/merchants/#{merchant.id}/items"

    expect(page).to have_content("Enabled Items:")
    expect(page).to have_content("Disabled Items:")
    expect(item3.name).to appear_before("Disabled Items")
    expect("Disabled Items:").to appear_before(item2.name)
    expect("Disabled Items:").to appear_before(item1.name)
  end

  describe 'most popular items section in merhcant items index' do
    it "lists the top 5 most popular items ranked by total revenue generated" do
      merchant = create(:merchant)
      item_1 = create(:item_with_transactions, merchant: merchant, name: "Toy", invoice_item_quantity: 4, invoice_item_unit_price: 1000)
      item_2 = create(:item_with_transactions, merchant: merchant, name: "Apple", invoice_item_quantity: 4, invoice_item_unit_price: 1000000)
      item_3 = create(:item_with_transactions, merchant: merchant, name: "Zebra", invoice_item_quantity: 4, invoice_item_unit_price: 100)
      item_4 = create(:item_with_transactions, merchant: merchant, name: "Bus", invoice_item_quantity: 4, invoice_item_unit_price: 100000)
      item_5 = create(:item_with_transactions, merchant: merchant, name: "Dog", invoice_item_quantity: 4, invoice_item_unit_price: 10000)
      item_6 = create(:item_with_transactions, merchant: merchant, name: "Legos", invoice_item_quantity: 4, invoice_item_unit_price: 10)

      visit "merchants/#{merchant.id}/items"

      within('div.top_items') do
        expect(page).to have_content("Apple")
        expect(page).to have_content("Bus")
        expect(page).to have_content("Dog")
        expect(page).to have_content("Toy")
        expect(page).to have_content("Zebra")
        expect(page).to_not have_content("Legos")
      end
    end

    it "each item name is a link to the merchants item show page for that item" do
      merchant = create(:merchant)
      item_1 = create(:item_with_transactions, merchant: merchant, name: "Toy")

      visit "merchants/#{merchant.id}/items"

      within "div.top_items" do
        within "div.top_item_#{item_1.id}" do
          click_link "Toy"
          expect(current_path).to eq("/merchants/#{merchant.id}/items/#{item_1.id}")
        end
      end
    end

    it "shows the total revenue generated next to each item name" do
      merchant = create(:merchant)
      item_1 = create(:item_with_transactions, merchant: merchant, name: "Toy", invoice_item_quantity: 4, invoice_item_unit_price: 100000)

      visit "merchants/#{merchant.id}/items"

      within "div.top_items" do
        within "div.top_item_#{item_1.id}" do
          expect(page).to have_content("Total Revenue: $4,000.00")
        end
      end
    end

    it "shows the date with the most sales for each item" do
      merchant = create(:merchant)
      invoice_1 = create(:invoice, created_at: DateTime.new(2022, 1, 10, 1, 1, 1))
      item_1 = create(:item_with_transactions, merchant: merchant, name: "Toy", invoice: invoice_1, invoice_item_quantity: 4, invoice_item_unit_price: 100000)

      #create a smaller invoice that should not affect top date
      invoice_2 = create(:invoice, created_at: DateTime.new(2022, 1, 10, 1, 1, 1))
      item_2 = create(:item_with_transactions, merchant: merchant, name: "Toy", invoice: invoice_2, invoice_item_quantity: 2, invoice_item_unit_price: 1000)
      item_2.invoice_items.update(item: item_1)

      #create an equal revenue invoice that should not affect top date becuase it is older
      invoice_3 = create(:invoice, created_at: DateTime.new(2022, 1, 5, 1, 1, 1))
      item_3 = create(:item_with_transactions, merchant: merchant, name: "Toy", invoice: invoice_3, invoice_item_quantity: 4, invoice_item_unit_price: 100000)
      item_3.invoice_items.update(item: item_1)

      visit "merchants/#{merchant.id}/items"

      within "div.top_items" do
        within "div.top_item_#{item_1.id}" do
          expect(page).to have_content("Top selling date for Toy was Monday, January 10, 2022.")
        end
      end
    end
  end
end
