require 'rails_helper'

describe "Admin Dashboad" do
  let!(:merchant_1) {Merchant.create!(name: "REI")}

  let!(:customer1) { Customer.create!(first_name: "Leanne", last_name: "Braun") }

  let!(:invoice1) { customer1.invoices.create!(status: 2, created_at: '2012-03-21 14:53:59') }
  let!(:invoice2) { customer1.invoices.create!(status: 2, created_at: '2012-03-23 14:53:59') }
  let!(:invoice3) { customer1.invoices.create!(status: 2, created_at: '2012-03-24 14:53:59') }
  let!(:invoice4) { customer1.invoices.create!(status: 2, created_at: '2012-03-25 14:53:59') }

  let!(:item1) {merchant_1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 135)}
  let!(:item2) {merchant_1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 219.99)}
  let!(:item3) {merchant_1.items.create!(name: "Backpack", description: "Can carry all your hiking snacks", unit_price: 99)}

  let!(:invoice_item1) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 130, status: "shipped") }
  let!(:invoice_item2) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 10, unit_price: 130, status: "pending") }
  let!(:invoice_item3) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 8, unit_price: 220, status: "packaged") }
  let!(:invoice_item4) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 1, unit_price: 100, status: "shipped") }
  let!(:invoice_item5) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice4.id, quantity: 1, unit_price: 100, status: "packaged") }

  before do
    visit admin_index_path
  end

  it "displays a header indicating that the user is on the admin dashboard" do

    expect(page).to have_content("Welcome to the Admin Dashboard")
  end

  it "displays links to the admin merchants index and admin invoices index" do
    click_link("Merchants Index")
    expect(current_path).to eq(admin_merchants_path)

    visit admin_index_path
    click_link("Invoices Index")
    expect(current_path).to eq(admin_invoices_path)
  end

  it "displays incomplete invoices and links to that invoices admin show page" do
    within ".incomplete-invoices" do
      expect(page).to have_link("#{invoice1.id}")
      expect(page).to have_link("#{invoice2.id}")
      expect(page).to have_link("#{invoice4.id}")
      expect(page).to_not have_link("#{invoice3.id}")

      click_link("#{invoice1.id}")
      expect(current_path).to eq(admin_invoice_path(invoice1))
    end
  end

  it "orders incomplete invoices by oldest to newest" do
    expect("#{invoice1.id}").to appear_before("#{invoice2.id}")
    expect("#{invoice2.id}").to appear_before("#{invoice4.id}")
  end
end
