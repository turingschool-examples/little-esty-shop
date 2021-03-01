require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  before :each do
    @customer1 = Customer.create!(first_name: "Bob", last_name: "Gu")
    @customer2 = Customer.create!(first_name: "Steve", last_name: "Smith")
    @customer3 = Customer.create!(first_name: "Jill", last_name: "Biden")
    @customer4 = Customer.create!(first_name: "Adriana", last_name: "Green")
    @customer5 = Customer.create!(first_name: "Sally", last_name: "May")
    @customer6 = Customer.create!(first_name: "Jo", last_name: "Shmoe")
    @customer7 = Customer.create!(first_name: "Molly", last_name: "Rae")

    @merchant1 = Merchant.create!(name: "Jimbo")
    @merchant2 = Merchant.create!(name: "Linda")

    @item1 = Item.create!(name: "spatula", description: "fold them eggs", unit_price: 14.00, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "bowling ball", description: "roll em if you got em", unit_price: 68.00, merchant_id: @merchant2.id)

    @invoice1 = Invoice.create!(customer_id: @customer1.id, status: "cancelled", created_at: "1990-03-23 21:40:46")
    @invoice2 = Invoice.create!(customer_id: @customer2.id, status: "in progress")
    @invoice3 = Invoice.create!(customer_id: @customer3.id, status: "completed", created_at: "1991-03-23 21:40:46")
    @invoice4 = Invoice.create!(customer_id: @customer4.id, status: "cancelled")
    @invoice5 = Invoice.create!(customer_id: @customer5.id, status: "completed")
    @invoice6 = Invoice.create!(customer_id: @customer6.id, status: "completed")
    @invoice7 = Invoice.create!(customer_id: @customer7.id, status: "completed")

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 28.00, status: "pending" )
    @invoice_item2 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice2.id, quantity: 1, unit_price: 68.00, status: "shipped" )
    @invoice_item3 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 68.00, status: "packaged" )

    @transaction1 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000000000, cc_expiration_date: '2000-01-01 00:00:00 -0500', result: true)
    @transaction2 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000001111, cc_expiration_date: '2001-01-01 00:00:00 -0500', result: true)
    @transaction3 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000002222, cc_expiration_date: '2002-01-01 00:00:00 -0500', result: true)
    @transaction4 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction5 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000004444, cc_expiration_date: '2004-01-01 00:00:00 -0500', result: true)
    @transaction6 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000004444, cc_expiration_date: '2004-01-01 00:00:00 -0500', result: true)
    @transaction7 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000004444, cc_expiration_date: '2005-01-01 00:00:00 -0500', result: true)
    @transaction8 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction9 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction10 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction11 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction12 = Transaction.create!(invoice_id: @invoice3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction13 = Transaction.create!(invoice_id: @invoice3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction14 = Transaction.create!(invoice_id: @invoice3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction15 = Transaction.create!(invoice_id: @invoice3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction16 = Transaction.create!(invoice_id: @invoice4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction17 = Transaction.create!(invoice_id: @invoice4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction18 = Transaction.create!(invoice_id: @invoice4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction19 = Transaction.create!(invoice_id: @invoice5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction20 = Transaction.create!(invoice_id: @invoice5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction21 = Transaction.create!(invoice_id: @invoice6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction22 = Transaction.create!(invoice_id: @invoice7.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: false)
  end

  it 'When I visit admin dashboard I see a header
   indicating that I am on the admin dashboard' do

    visit admin_dashboard_index_path

    expect(page).to have_content("Admin Dashboard")
    expect(page).to have_link("Admin Merchants Index")
    expect(page).to have_link("Admin Invoices Index")
  end

  it 'I see the names of the top 5 customers' do
    visit admin_dashboard_index_path

    expect(page).to have_content(@customer1.first_name)
    expect(page).to have_content(@customer2.first_name)
    expect(page).to have_content(@customer3.first_name)
    expect(page).to have_content(@customer4.first_name)
    expect(page).to have_content(@customer5.first_name)
    expect(page).to_not have_content(@customer6.first_name)
    expect(page).to_not have_content(@customer7.first_name)
  end

  it 'next to each customer name I see the number of
    successful transactions they have conducted with my merchant' do

    visit admin_dashboard_index_path

    within("#top_customers-#{@customer1.id}") do
      expect(page).to have_content(@customer1.first_name)
      expect(page).to have_content(6)
    end
  end

  it 'I see a section for Incomplete Invoices,
    that section I see a list of the ids of all invoices
    That have items that have not yet been shipped,
    And each invoice id links to that invoices admin show page' do

    visit admin_dashboard_index_path

    expect(page).to have_content("Incomplete Invoices")

    within("#incomplete_invoices") do
      expect(page).to have_link(@invoice1.id)
      expect(page).to have_link(@invoice3.id)
    end
  end

  it 'In the section for "Incomplete Invoices", Next to each
    invoice id I see the date that the invoice was created
    And I see the date formatted like "Monday, July 18, 2019"
    And I see that the list is ordered from oldest to newest' do

    visit admin_dashboard_index_path
    within("#created_at_incomplete_invoice_items-#{@invoice1.id}") do
      expect(page).to have_content(@invoice_item1.invoice.format_time)
    end
    save_and_open_page

    within("#incomplete_invoices") do
      # expect(@invoice1.id).to appear_before(@invoice3.id)
      # expect(@invoice3.id).to_not appear_before(@invoice1.id)
      expect(@invoice_item1.invoice.format_time).to appear_before(@invoice_item3.invoice.format_time)
    end
  end
end
