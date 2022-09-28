require 'rails_helper'

RSpec.describe 'merchant bulk discount create' do

  it 'can display discounted revenue' do
    merchant1 = Merchant.create!(name: "Robespierre", status: 'Enabled')
    merchant2 = Merchant.create!(name: "Jack", status: 'Enabled')

    customer1 = Customer.create(first_name: 'Jack', last_name: 'Black')

    discount1 = BulkDiscount.create(merchant_id: merchant1.id, threshold: 15, discount: 10)
    discount2 = BulkDiscount.create(merchant_id: merchant1.id, threshold: 26, discount: 50)
    discount3 = BulkDiscount.create(merchant_id: merchant1.id, threshold: 10, discount: 5)
    discount4 = BulkDiscount.create(merchant_id: merchant2.id, threshold: 18, discount: 80)

    invoice1 = Invoice.create(status: "completed", customer_id: customer1.id)
    invoice2 = Invoice.create(status: "completed", customer_id: customer1.id)
    invoice3 = Invoice.create(status: "completed", customer_id: customer1.id)

    item1 = Item.create(name: 'Fountian Pen', description: 'The fanciest of pens', unit_price: 10, merchant_id: merchant1.id)
    item2 = Item.create(name: 'Mech Pencil', description: 'The fanciest of pencils', unit_price: 10, merchant_id: merchant2.id)

    invoice_item1 = InvoiceItem.create(invoice_id: invoice1.id, item_id: item1.id, quantity: 24, unit_price: 1000, status: 'shipped')
    invoice_item2 = InvoiceItem.create(invoice_id: invoice2.id, item_id: item2.id, quantity: 28, unit_price: 100, status: 'shipped')
    invoice_item3 = InvoiceItem.create(invoice_id: invoice3.id, item_id: item1.id, quantity: 30, unit_price: 1000, status: 'shipped')

    visit admin_invoice_path(invoice1.id)

    expect(page).to have_content('Total Revenue: $240.00')
    expect(page).to have_content('Discounted Revenue: $216.00')
  end

end
