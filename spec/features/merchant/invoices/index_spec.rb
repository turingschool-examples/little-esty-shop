require 'rails_helper'

RSpec.describe 'Merchant Invoices Index page' do
  it 'displays all invoices for merchant' do
    merchant1 = Merchant.create!(name: 'Chuckin Pucks')
    customer = Customer.create!(first_name: 'Samantha', last_name: 'Ore')
    customer_2 = Customer.create!(first_name: 'Jake', last_name: 'Statefarm')
    invoice_1 = Invoice.create!(customer_id: customer.id, status: 2)
    invoice_1a = Invoice.create!(customer_id: customer.id, status: 2)
    invoice_2 = Invoice.create!(customer_id: customer.id, status: 2)
    invoice_3 = Invoice.create!(customer_id: customer.id, status: 2)
    invoice_4 = Invoice.create!(customer_id: customer_2.id, status: 2)

    item_1 = Item.create!(name: "Shampoo", description: "Cleans the lettuce", unit_price: 5, merchant_id: merchant1.id)
    item_2 = Item.create!(name: "Tape", description: "Grips and rips pucks", unit_price: 2, merchant_id: merchant1.id)
    item_3 = Item.create!(name: "Blade Butter", description: "Keeps the tape dry", unit_price: 5, merchant_id: merchant1.id)
    item_4 = Item.create!(name: "Helmet", description: "Protects your noggin", unit_price: 5, merchant_id: merchant1.id)
    item_5 = Item.create!(name: "Bag", description: "Carries your shit", unit_price: 5, merchant_id: merchant1.id)

    ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
    ii_2 = InvoiceItem.create!(invoice_id: invoice_1a.id, item_id: item_2.id, quantity: 1, unit_price: 10, status: 1, created_at: "2012-03-29 14:54:09")
    ii_3 = InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 9, unit_price: 10, status: 1, created_at: "2012-03-27 14:54:09")
    
    transaction1 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: invoice_1.id)
    transaction2 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: invoice_1a.id)
    transaction2 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: invoice_2.id)
    transaction2 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: invoice_3.id)
    transaction2 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: invoice_4.id)

    visit "/merchants/#{merchant1.id}/invoices"

    expect(page).to have_content(invoice_1.id)
    expect(page).to have_content(invoice_1a.id)
  end
end