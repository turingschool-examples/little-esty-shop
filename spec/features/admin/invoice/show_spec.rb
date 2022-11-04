require 'rails_helper'

RSpec.describe 'admin/invoices/invoice.id' do
  before :each do
    @customer_1 = Customer.create!(first_name: 'Eli', last_name: 'Fuchsman')
    @customer_2 = Customer.create!(first_name: 'Bryan', last_name: 'Keener')
    @customer_3 = Customer.create!(first_name: 'Darby', last_name: 'Smith')
    @customer_4 = Customer.create!(first_name: 'James', last_name: 'White')
    @customer_5 = Customer.create!(first_name: 'William', last_name: 'Lampke')
    @customer_6 = Customer.create!(first_name: 'Abdul', last_name: 'Redd')

    @merchant = Merchant.create!(name: 'Test')

    @item_1 = Item.create!(name: 'item1', description: 'desc1', unit_price: 10, merchant_id: @merchant.id)

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1)
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 1)
    @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: 1)
    @invoice_4 = Invoice.create!(customer_id: @customer_4.id, status: 1)
    @invoice_5 = Invoice.create!(customer_id: @customer_5.id, status: 1)
    @invoice_6 = Invoice.create!(customer_id: @customer_2.id, status: 1)
    @invoice_7 = Invoice.create!(customer_id: @customer_2.id, status: 1)
    @invoice_8 = Invoice.create!(customer_id: @customer_4.id, status: 1)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10,
                                status: 1)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10,
                                status: 1)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_1.id, quantity: 2, unit_price: 10,
                                status: 1)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_1.id, quantity: 3, unit_price: 10,
                                status: 1)
    @ii_5 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_1.id, quantity: 1, unit_price: 10,
                                status: 1)

    @transaction_1 = Transaction.create!(credit_card_number: '1', result: 0, invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: '2', result: 0, invoice_id: @invoice_2.id)
    @transaction_3 = Transaction.create!(credit_card_number: '3', result: 0, invoice_id: @invoice_3.id)
    @transaction_4 = Transaction.create!(credit_card_number: '4', result: 0, invoice_id: @invoice_4.id)
    @transaction_5 = Transaction.create!(credit_card_number: '5', result: 0, invoice_id: @invoice_5.id)
    @transaction_6 = Transaction.create!(credit_card_number: '5', result: 0, invoice_id: @invoice_6.id)
    @transaction_7 = Transaction.create!(credit_card_number: '5', result: 0, invoice_id: @invoice_7.id)
    @transaction_8 = Transaction.create!(credit_card_number: '5', result: 0, invoice_id: @invoice_8.id)
  end
  it 'shows related information to a specific invoice' do
    visit "/admin/invoices/#{@invoice_1.id}"
    expect(page).to have_content("Id: #{@invoice_1.id}")
    expect(page).to have_content('Status: completed')
    expect(page).to have_content('Customer Name: Eli Fuchsman')
  end
#   When I visit an admin invoice show page
# Then I see all of the items on the invoice including:
# - Item name
# - The quantity of the item ordered
# - The price the Item sold for
# - The Invoice Item status
  it 'shows all items on the invoice including item name, quantity, price, status' do
    visit "/admin/invoices/#{@invoice_1.id}"
    # within("#invoice_item-#{invoice}")
    expect(page).to have_content('Invoice Items:')
    expect(page).to have_content('Item Name: item1')
    expect(page).to have_content('Unit Price: 10')
    expect(page).to have_content('Quantity: 9')
    expect(page).to have_content('Status: packaged')

  end
#   When I visit an admin invoice show page
# Then I see the total revenue that will be generated from this invoice
  it 'i see the total revenue that will be generated from this invoice' do
    visit "/admin/invoices/#{@invoice_1.id}"
    save_and_open_page
  end
end