require 'rails_helper'

RSpec.describe 'Admin invoices show page' do
  before :each do
    @cust_1 = Customer.create!(first_name: "Debbie", last_name: "Twolegs")
    @cust_2 = Customer.create!(first_name: "Tommy", last_name: "Doubleleg")
    @cust_3 = Customer.create!(first_name: "Brian", last_name: "Twinlegs")
    @cust_4 = Customer.create!(first_name: "Jared", last_name: "Goffleg")
    @cust_5 = Customer.create!(first_name: "Pistol", last_name: "Pete")
    @cust_6 = Customer.create!(first_name: "Bronson", last_name: "Shmonson")
    @cust_7 = Customer.create!(first_name: "Anten", last_name: "Branden")
    @invoice_1 = @cust_1.invoices.create!(status: 1)
    @invoice_2 = @cust_1.invoices.create!(status: 1)
    @invoice_3 = @cust_1.invoices.create!(status: 1)
    @invoice_4 = @cust_2.invoices.create!(status: 1)
    @invoice_5 = @cust_2.invoices.create!(status: 1)
    @invoice_6 = @cust_2.invoices.create!(status: 1)
    @invoice_7 = @cust_3.invoices.create!(status: 1)
    @invoice_8 = @cust_3.invoices.create!(status: 1)
    @invoice_9 = @cust_4.invoices.create!(status: 1)
    @invoice_10 = @cust_4.invoices.create!(status: 1)
    @invoice_11 = @cust_5.invoices.create!(status: 1)
    @invoice_12 = @cust_5.invoices.create!(status: 1)
    @invoice_13 = @cust_6.invoices.create!(status: 1)
    @invoice_14 = @cust_7.invoices.create!(status: 1)
    @invoice_15 = @cust_7.invoices.create!(status: 2)
  end

  it 'displays the invoices id, status, created time, and customers first and last name' do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content("#{@invoice_1.id}")
    expect(page).to have_content("Status: in progress")
    expect(page).to have_content("#{@invoice_1.created_at.strftime("%A %b %M %Y")}")
    expect(page).to have_content("Debbie Twolegs")
  end

  it 'displays total revenue for invoice' do
    merch_1 = Merchant.create!(name: "Two-Legs Fashion")

    item_1 = merch_1.items.create!(name: "Two-Leg Pantaloons", description: "pants built for people with two legs", unit_price: 5000)

    InvoiceItem.create!(item_id: item_1.id, invoice_id: @invoice_1.id, quantity: 3, unit_price: item_1.unit_price, status: 2)
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content("Total Revenue: $150.00")
  end
end