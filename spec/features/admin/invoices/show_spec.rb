require 'rails_helper'

RSpec.describe "Admin Invoice Show Page" do
  before :each do
    @billman = Merchant.create!(name: "Billman")

    @bracelet = @billman.items.create!(name: "Bracelet", description: "shiny", unit_price: 1001)
    @mood = @billman.items.create!(name: "Mood Ring", description: "Moody", unit_price: 2002)
    @necklace = @billman.items.create!(name: "Necklace", description: "Sparkly", unit_price: 3045)

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: "Ondricka")

    @invoice_1 = @customer_1.invoices.create!(status: "cancelled")
    @invoice_2 = @customer_1.invoices.create!(status: "in progress")

    @invoice_items_1 = @bracelet.invoice_items.create!(quantity: 1, unit_price: 1001, status: "Pending", invoice_id: @invoice_1.id)
    @invoice_items_2 = @mood.invoice_items.create!(quantity: 1, unit_price: 2002, status: "Pending", invoice_id: @invoice_2.id)
    @invoice_items_3 = @necklace.invoice_items.create!(quantity: 1, unit_price: 3003, status: "Pending", invoice_id: @invoice_1.id)
  end

  it "shows all attributes of an invoice" do
    visit "/admin/invoices/#{@invoice_1.id}"
    expect(page).to have_content("Invoice ID: #{@invoice_1.id}")
    expect(page).to have_content("Invoice Status: #{@invoice_1.status}")
    expect(page).to have_content("Customer Name: #{@customer_1.first_name} #{@customer_1.last_name}")
    expect(page).to_not have_content("Invoice ID: #{@invoice_2.id}")
    expect(page).to_not have_content("Invoice Status: #{@invoice_2.status}")
  end

  it "shows item attributes for items on an invoice" do
    visit "/admin/invoices/#{@invoice_1.id}"
    expect(page).to have_content("Item Name: Bracelet")
    expect(page).to have_content("Item Name: Necklace")
    expect(page).to have_content("Quantity: 1")
    expect(page).to have_content("Price Sold For: $10.01")
    expect(page).to have_content("Price Sold For: $30.03")
    expect(page).to have_content("Item Status: Pending")

    expect(page).to_not have_content("Item Name: Mood Ring")
    expect(page).to_not have_content("Price Sold For: $20.02")
  end

  it "shows total revenue in dollars for an invoice" do
    visit "/admin/invoices/#{@invoice_1.id}"
    expect(page).to have_content("Total Revenue from this Invoice: $40.04")
    expect(page).to_not have_content("Total Revenue from this Invoice: $20.02")
  end

  it "can update invoice status via a select form" do
    visit "/admin/invoices/#{@invoice_1.id}"
    expect(page).to have_content("Invoice Status: cancelled")
    select "in progress", from: :status
    click_button("Update Status")
    expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
    expect(page).to have_content("Invoice Status: in progress")
  end
end
