require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Tillman Group')
    @merchant_2 = Merchant.create!(name: 'Kozy Group')

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
    @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Osinski')
    @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Toy')
    @customer_4 = Customer.create!(first_name: 'Leanne', last_name: 'Braun')
    @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer_6 = Customer.create!(first_name: 'Heber', last_name: 'Kuhn')
    @customer_7 = Customer.create!(first_name: 'Parker', last_name: 'Daugherty')

    @invoice_1 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}", created_at: "2012-03-25 09:54:09 UTC")
    @invoice_2 = Invoice.create!(status: 1, customer_id: "#{@customer_1.id}")
    @invoice_3 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}", created_at: '2012-03-24 09:54:09 UTC')
    @invoice_4 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}", created_at: '2012-03-23 09:54:09 UTC')
    @invoice_5 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}", created_at: '2012-03-22 09:54:09 UTC')
    @invoice_6 = Invoice.create!(status: 0, customer: @customer_1)
    @invoice_7 = Invoice.create!(status: 0, customer: @customer_2)
    @invoice_8 = Invoice.create!(status: 0, customer: @customer_2)
    @invoice_9 = Invoice.create!(status: 0, customer: @customer_2)
    @invoice_10 = Invoice.create!(status: 0, customer: @customer_2)
    @invoice_11 = Invoice.create!(status: 0, customer: @customer_3)
    @invoice_12 = Invoice.create!(status: 0, customer: @customer_3)
    @invoice_13 = Invoice.create!(status: 0, customer: @customer_3)
    @invoice_14 = Invoice.create!(status: 0, customer: @customer_4)
    @invoice_15 = Invoice.create!(status: 0, customer: @customer_4)
    @invoice_16 = Invoice.create!(status: 0, customer: @customer_5)

    @invoice_1.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_4.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_5.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_6.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_7.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_8.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_9.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_10.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_11.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_12.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_13.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_14.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_15.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_16.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')

    @item_1 = @merchant_1.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_2 = @merchant_1.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_3 = @merchant_1.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_4 = @merchant_1.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_5 = @merchant_1.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_6 = @merchant_1.items.create!(name: 'item 1', description: 'item', unit_price: 1000)

    InvoiceItem.create!(invoice: @invoice_1, item: @item_1, quantity: 0, unit_price: 1000, status: 0)
    InvoiceItem.create!(invoice: @invoice_3, item: @item_3, quantity: 0, unit_price: 1000, status: 0)
    InvoiceItem.create!(invoice: @invoice_4, item: @item_4, quantity: 0, unit_price: 1000, status: 1)
    InvoiceItem.create!(invoice: @invoice_5, item: @item_5, quantity: 0, unit_price: 1000, status: 0)
    InvoiceItem.create!(invoice: @invoice_6, item: @item_6, quantity: 0, unit_price: 1000, status: 2)

    visit "/admin"
  end

  it 'displays header indicating admin dashboard' do
    expect(page).to have_content("Admin Dashboard")
  end

  it 'displays a link to admin merchants index' do
    expect(page).to have_link("Merchants")
  end

  it 'displays a link to admin invoices index' do
    expect(page).to have_link("Invoices")
  end

  it 'the link directs the user to the merchant index' do
    click_on "Merchants"

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content(Merchant.first.name)
    expect(page).to have_content(Merchant.last.name)
  end

  it 'the link directs the user to the invoice index' do
    click_on "Invoices"

    expect(current_path).to eq("/admin/invoices")
    expect(page).to have_content(Invoice.first.id)
    expect(page).to have_content(Invoice.last.id)
  end

  it 'displays the top five customers' do

    expect(page).to have_content('Top Customers')
    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.last_name)
    expect(page).to have_content(@customer_2.first_name)
    expect(page).to have_content(@customer_2.last_name)
    expect(page).to have_content(@customer_3.first_name)
    expect(page).to have_content(@customer_3.last_name)
    expect(page).to have_content(@customer_4.first_name)
    expect(page).to have_content(@customer_4.last_name)
    expect(page).to have_content(@customer_5.first_name)
    expect(page).to have_content(@customer_5.last_name)
    expect(page).to_not have_content(@customer_6.first_name)
  end

  it 'displays the top 5 customers in order of most transactions' do

    expect(@customer_1.first_name).to appear_before(@customer_2.first_name)
    expect(@customer_2.first_name).to appear_before(@customer_3.first_name)
    expect(@customer_3.first_name).to appear_before(@customer_4.first_name)
    expect(@customer_4.first_name).to appear_before(@customer_5.first_name)
  end

  it 'displays the invoice ids with items that have not been shipped' do

    expect(page).to have_content('Incomplete Invoices')
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_3.id)
    expect(page).to have_content(@invoice_4.id)
    expect(page).to have_content(@invoice_5.id)
    expect(page).to_not have_content(@invoice_6.id)
  end

  it 'displays the incomplete invoices in order by least recent creation date' do

    expect(@invoice_5.created_at.strftime("%A, %B %d, %Y")).to appear_before(@invoice_4.created_at.strftime("%A, %B %d, %Y"))
    expect(@invoice_4.created_at.strftime("%A, %B %d, %Y")).to appear_before(@invoice_3.created_at.strftime("%A, %B %d, %Y"))
    expect(@invoice_3.created_at.strftime("%A, %B %d, %Y")).to appear_before(@invoice_1.created_at.strftime("%A, %B %d, %Y"))

  end
end
