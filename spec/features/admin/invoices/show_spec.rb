require 'rails_helper'

RSpec.describe 'Admin Invoice Show Page' do
  before(:each) do
    @merch_1 = Merchant.create!(name: "Shop Here")

    @item_1 = Item.create!(name:"jumprope", description:"Pink and sparkly.", unit_price:600, merchant_id:"#{@merch_1.id}")
    @item_2 = Item.create!(name:"hula hoop", description:"Get your groove on!", unit_price:700, merchant_id:"#{@merch_1.id}")

    @cust_1 = Customer.create!(first_name:"Hannah", last_name:"Warner")

    @invoice_1 = Invoice.create!(customer_id:"#{@cust_1.id}", status:1)
    @invoice_2 = Invoice.create!(customer_id:"#{@cust_1.id}", status:1)
    @invoice_3 = Invoice.create!(customer_id:"#{@cust_1.id}", status:1)

    @invoice_item_1 = InvoiceItem.create!(invoice_id:"#{@invoice_1.id}", item_id:"#{@item_1.id}", status: 2, quantity:1, unit_price:600)
    @invoice_item_2 = InvoiceItem.create!(invoice_id:"#{@invoice_2.id}", item_id:"#{@item_2.id}", status: 2, quantity:1, unit_price:700)
    @invoice_item_3 = InvoiceItem.create!(invoice_id:"#{@invoice_3.id}", item_id:"#{@item_2.id}", status: 2, quantity:1, unit_price:700)
  end
  # As an admin,
  # When I visit an admin invoice show page
  # Then I see information related to that invoice including:
  #
  # Invoice id
  # Invoice status
  # Invoice created_at date in the format "Monday, July 18, 2019"
  # Customer first and last name

  it 'shows information for the invoice' do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content("Invoice ID: #{@invoice_1.id}")
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content(@cust_1.first_name)
    expect(page).to have_content(@cust_1.last_name)
  end
end
