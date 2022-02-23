require 'rails_helper'

RSpec.describe 'Invoices', type: :feature do
  before do

    @merchant1 = Merchant.create!(name: "The Tornado")
    @item1 = @merchant1.items.create!(name: "SmartPants", description: "IQ + 20", unit_price: 125)
    @customer1 = Customer.create!(first_name: "Marky", last_name: "Mark" )
    @customer2 = Customer.create!(first_name: "Larky", last_name: "Lark" )
    @customer3 = Customer.create!(first_name: "Sparky", last_name: "Spark" )
    @invoice1 = @customer1.invoices.create!(status: 1)
    @invoice2 = @customer2.invoices.create!(status: 1)
    @invoice3 = @customer2.invoices.create!(status: 1)
    @invoice_item1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 2, unit_price: 125, status: 1)
  end


  it "has a link to the invoice page" do
    visit "/admin/invoices/#{@invoice1.id}"

    expect(page).to have_content("Customer name: Marky Mark")
    expect(page).to have_content("Customer ID: #{@customer1.id}")
    expect(page).to have_content("Invoice Status: #{@invoice1.status}")
    expect(page).to have_content("Invoice Created: #{@invoice1.created_at.strftime("%A, %B, %d, %Y")}")
    expect(page).to have_content("Invoice ID: #{@invoice1.id}")
  end

  it "tests for sad path attributes" do #unable to sad path status and created_at as they could creat a failure.
    visit "/admin/invoices/#{@invoice1.id}"

    expect(page).to_not have_content("Customer name: Sparky Spark")
    expect(page).to_not have_content("Customer ID: #{@customer2.id}")
    expect(page).to_not have_content("Invoice ID: #{@invoice2.id}")
  end
end
