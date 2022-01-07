require 'rails_helper'
describe 'merchants invoices index page' do
  xit 'has all invoices that include atleast one of a merchants items' do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    merchant_2 = Merchant.create!(name: 'merchant_2')
    customer_1 = Customer.create!(first_name: 'customer_1', last_name: 'last_name_1')
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
    invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 1)
    invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 1)
    item_1 = Item.create!(name: 'item_1', description: 'item_1_description', unit_price: 1, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: 'item_2', description: 'item_2_description', unit_price: 2, merchant_id: merchant_1.id)
    item_3 = Item.create!(name: 'item_3', description: 'item_2_description', unit_price: 2, merchant_id: merchant_2.id)
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 2, status: 1)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 3, status: 2)
    invoice_item_2 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 2, unit_price: 3, status: 2)
    visit "/merchants/#{merchant_1.id}/invoices"
    save_and_open_page
    expect(page).to have_content("Invoices: #{invoice_1.id} #{invoice_2.id}")
    expect(page).to_not have_content(invoice_3.id)
  end
end
