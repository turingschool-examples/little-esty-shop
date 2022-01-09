require 'rails_helper'

RSpec.describe "Merchant invoice index page", type: :feature do
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

  it "shows all invoices which include at least one of this merchant's items" do

    visit "/merchants/#{@merch_1.id}/invoices"
    expect(page).to have_content("Invoice No. #{@invoice_1.id}")
    expect(page).to have_content("Invoice No. #{@invoice_2.id}")
    expect(page).to have_content("Invoice No. #{@invoice_3.id}")
  end

  it "shows each invoice id and id links to the merchant invoice show page" do
    visit "/merchants/#{@merch_1.id}/invoices"

    click_link "Invoice No. #{@invoice_1.id}"
    expect(current_path).to eq("/merchants/#{@merch_1.id}/invoices/#{@invoice_1.id}")
  end
end
