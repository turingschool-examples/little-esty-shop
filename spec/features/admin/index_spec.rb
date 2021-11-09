require 'rails_helper'

RSpec.describe 'Admin Index' do
  it 'has a header that lets the user know they are on the admin dashboard' do
    visit admin_index_path

    expect(page).to have_content('Admin Dashboard')
  end

  it 'has a link to the admin merchants page' do
    visit admin_index_path

    click_link "Merchants"

    expect(current_path).to eq('/admin/merchants')
  end

  it 'has a link to the admin invoices page' do
    visit admin_index_path

    click_link "Invoices"

    expect(current_path).to eq('/admin/invoices')
  end

  it 'has statistics about the best customers' do
    customer1 = Customer.create!(first_name: "Bob", last_name: "Dylan")
    customer2 = Customer.create!(first_name: "Micha", last_name: "B")
    customer3 = Customer.create!(first_name: "Christian", last_name: "V")
    invoice1 = Invoice.create!(customer_id: customer1.id, status: 'completed')
    invoice2 = Invoice.create!(customer_id: customer1.id, status: 'completed')
    invoice3 = Invoice.create!(customer_id: customer1.id, status: 'completed')
    invoice4 = Invoice.create!(customer_id: customer2.id, status: 'completed')
    invoice5 = Invoice.create!(customer_id: customer2.id, status: 'completed')
    invoice6 = Invoice.create!(customer_id: customer3.id, status: 'completed')
    invoice7 = Invoice.create!(customer_id: customer3.id, status: 'completed')
    transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 123, credit_card_expiration_date: nil, result: 'success')
    transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 123, credit_card_expiration_date: nil, result: 'success')
    transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: 123, credit_card_expiration_date: nil, result: 'success')
    transaction4 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: 123, credit_card_expiration_date: nil, result: 'success')
    transaction5 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: 123, credit_card_expiration_date: nil, result: 'success')
    transaction6 = Transaction.create!(invoice_id: invoice6.id, credit_card_number: 123, credit_card_expiration_date: nil, result: 'success')
    transaction7 = Transaction.create!(invoice_id: invoice7.id, credit_card_number: 123, credit_card_expiration_date: nil, result: 'failed')
    transaction8 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 123, credit_card_expiration_date: nil, result: 'success')

    visit admin_index_path

    expect(page).to have_content("Top Customers")

    second_customer = "#{customer2.first_name} #{customer2.last_name} - 2 purchase(s)"
    first_customer = "#{customer1.first_name} #{customer1.last_name} - 4 purchase(s)"
    third_customer = "#{customer3.first_name} #{customer3.last_name} - 1 purchase(s)"

    expect(first_customer).to appear_before(second_customer)
    expect(second_customer).to appear_before(third_customer)
  end

  it 'has a section for incomplete invoices' do
    merchant1 = Merchant.create!(name: 'Bob Burger')
    customer1 = Customer.create!(first_name: "Bob", last_name: "Dylan")
    invoice1 = Invoice.create!(customer_id: customer1.id, status: 'in progress')
    invoice2 = Invoice.create!(customer_id: customer1.id, status: 'completed')
    invoice3 = Invoice.create!(customer_id: customer1.id, status: 'in progress')
    item1 = Item.create!(name: 'book', description: 'good book', unit_price: 12, merchant_id: merchant1.id)
    item2 = Item.create!(name: 'spatula', description: 'good spatula', unit_price: 8, merchant_id: merchant1.id)
    item3 = Item.create!(name: 'compressed air', description: 'working gpu', unit_price: 6000, merchant_id: merchant1.id)
    invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 2, unit_price: 24, status: 'pending')
    invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 2, unit_price: 16, status: 'shipped')
    invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 2, unit_price: 12000, status: 'packaged')


    visit admin_index_path

    first_invoice = "Invoice ##{invoice3.id} - #{invoice3.created_at.strftime("%A, %B %-d, %Y")}"
    second_invoice = "Invoice ##{invoice1.id} - #{invoice1.created_at.strftime("%A, %B %-d, %Y")}"

    expect(page).to have_content('Incomplete Invoices')

    within "#id-#{invoice3.id}" do
      expect(page).to have_content("Invoice ##{invoice3.id} - #{invoice3.created_at.strftime("%A, %B %-d, %Y")}")
    end

    within "#id-#{invoice1.id}" do
      expect(page).to have_content("Invoice ##{invoice1.id} - #{invoice1.created_at.strftime("%A, %B %-d, %Y")}")
    end

    #need to figure out how to test order by date
    # expect(invoice1.created_at.strftime("%A, %B %-d, %Y")).to appear_before(invoice3.created_at.strftime("%A, %B %-d, %Y"))
    expect("Invoice ##{invoice1.id}").to appear_before("Invoice ##{invoice3.id}", only_text: true)
    
    # expect(invoice1.id).to appear_before(invoice3.id)

    click_link "#{invoice3.id}"

    expect(current_path).to eq("/admin/invoices/#{invoice3.id}")
  end
end
