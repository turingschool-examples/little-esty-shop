require 'rails_helper'

RSpec.describe 'merchant items index page' do
  before :each do
    @merch_1 = Merchant.create!(name: "Two-Legs Fashion")
    @merch_2 = Merchant.create!(name: "One-Legs Fashion")

    @item_1 = @merch_1.items.create!(name: "Two-Leg Pantaloons", description: "pants built for people with two legs", unit_price: 5000)
    @item_2 = @merch_1.items.create!(name: "Two-Leg Shorts", description: "shorts built for people with two legs", unit_price: 6000)
    @item_3 = @merch_1.items.create!(name: "Hat", description: "hat built for people with two legs and one head", unit_price: 7000)
    @item_4 = @merch_1.items.create!(name: "Double Legged Pant", description: "pants built for people with two legs", unit_price: 8000)
    @item_5 = @merch_1.items.create!(name: "Stainless Steel, 5-Pocket Jean", description: "Shorts of Steel", unit_price: 9000)
    @item_6 = @merch_1.items.create!(name: "String of Numbers", description: "54921752964273", unit_price: 10000)
    @item_7 = @merch_2.items.create!(name: "Pirate Pants", description: "Peg legs don't need pant legs", unit_price: 1000)

    @cust_1 = Customer.create!(first_name: "Debbie", last_name: "Twolegs")

    @invoice_1 = @cust_1.invoices.create!(status: 2)

    @ii_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: @item_1.unit_price, status: 0)
    @ii_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: @item_2.unit_price, status: 0)
    @ii_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: @item_3.unit_price, status: 0)
    @ii_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: @item_4.unit_price, status: 0)
    @ii_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: @item_5.unit_price, status: 2)
    @ii_6 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: @item_6.unit_price, status: 2)

  end

  it 'displays a list of the names of all the merchants items and none from any other merchant' do
    visit "merchants/#{@merch_1.id}/items"
    expect(page).to have_content("Two-Leg Pantaloons")
    expect(page).to have_content("Two-Leg Shorts")
    expect(page).to have_content("Hat")
    expect(page).to have_content("Double Legged Pant")
    expect(page).to have_content("Stainless Steel, 5-Pocket Jean")
    expect(page).to have_content("String of Numbers")
    expect(page).to_not have_content("Pirate Pants")
  end

  it 'can disable/enable an item and the items are separated and displayed by status' do
    visit "/merchants/#{@merch_1.id}/items"
    within "#disabled" do
      within "#item-#{@item_1.id}" do
        expect(page).to_not have_button("Disable")
        click_button("Enable")
        expect(current_path).to eq("/merchants/#{@merch_1.id}/items")
      end
    end
    within "#enabled" do
      within "#item-#{@item_1.id}" do
        expect(page).to_not have_button("Enable")
        click_button("Disable")
        expect(current_path).to eq("/merchants/#{@merch_1.id}/items")
      end
    end
  end

  it 'has a link to create a new item' do
    visit "/merchants/#{@merch_1.id}/items"
    click_link("New Item")
    expect(current_path).to eq("/merchants/#{@merch_1.id}/items/new")

  end

  it "lists the 5 most popular items by revenue" do
    visit "/merchants/#{@merch_1.id}/items"

    within "#top_5_items" do
      expect(@item_6.name).to appear_before(@item_5.name)
      expect(@item_5.name).to appear_before(@item_4.name)
      expect(@item_4.name).to appear_before(@item_3.name)
      expect(page).to_not have_content(@item_1.name)

      expect(page).to have_content("Total Revenue: $100.00")
      expect(page).to have_content("Total Revenue: $90.00")
      expect(page).to have_content("Total Revenue: $80.00")
      expect(page).to have_content("Total Revenue: $70.00")
      expect(page).to have_content("Total Revenue: $60.00")
    end
  end
end
