require 'rails_helper'

describe 'Admin Dashboard Index Page' do
  before :each do 
    @m1 = Merchant.create!(name: 'Merchant 1')

    @c1 = Customer.create!(first_name: 'Bilbo', last_name: 'Baggins')
    @c2 = Customer.create!(first_name: 'Frodo', last_name: 'Baggins')
    @c3 = Customer.create!(first_name: 'Samwise', last_name: 'Gamgee')
    @c4 = Customer.create!(first_name: 'Aragorn', last_name: 'Elessar')
    @c5 = Customer.create!(first_name: 'Arwen', last_name: 'Undomiel')
    @c6 = Customer.create!(first_name: 'Legolas', last_name: 'Greenleaf')

    @i1 = Invoice.create!(merchant_id: @m1.id, customer_id: @c1.id, status: 2)
    @i2 = Invoice.create!(merchant_id: @m1.id, customer_id: @c1.id, status: 2)
    @i3 = Invoice.create!(merchant_id: @m1.id, customer_id: @c2.id, status: 2)
    @i4 = Invoice.create!(merchant_id: @m1.id, customer_id: @c3.id, status: 2)
    @i5 = Invoice.create!(merchant_id: @m1.id, customer_id: @c4.id, status: 2)

    @t1 = Transaction.create!(invoice_id: @i1.id, credit_card_number: 00000, credit_card_expiration_date: 00000, result: 1)
    @t2 = Transaction.create!(invoice_id: @i2.id, credit_card_number: 00000, credit_card_expiration_date: 00000, result: 1)
    @t3 = Transaction.create!(invoice_id: @i3.id, credit_card_number: 00000, credit_card_expiration_date: 00000, result: 1)
    @t4 = Transaction.create!(invoice_id: @i4.id, credit_card_number: 00000, credit_card_expiration_date: 00000, result: 1)
    @t5 = Transaction.create!(invoice_id: @i5.id, credit_card_number: 00000, credit_card_expiration_date: 00000, result: 1)

    @item_1 = Item.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10, merchant_id: @m1.id)
    @item_2 = Item.create!(name: 'Conditioner', description: 'This makes your hair shiny', unit_price: 8, merchant_id: @m1.id)
    @item_3 = Item.create!(name: 'Brush', description: 'This takes out tangles', unit_price: 5, merchant_id: @m1.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @i2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @i3.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 1)
    visit admin_dashboard_index_path
  end

  it 'should display a header indicating the admin dashboard' do
    expect(page).to have_content('Admin Dashboard')
  end

  it 'should have link to admin merchant index' do
    expect(page).to have_link('Merchants')

    click_link 'Merchants'
    expect(current_path).to eq(admin_merchants_path)
  end

  it 'should have link to admin invoice index' do
    expect(page).to have_link('Invoices')

    click_link 'Invoices'
    expect(current_path).to eq(admin_invoices_path)
  end

  it 'should display the top 5 customers with largest successful transactions' do
    expect(page).to have_content('Top 5 Customers')

    expect(page).to have_content(@c1.first_name)
    expect(page).to have_content(@c1.last_name)

    expect(page).to have_content(@c2.first_name)
    expect(page).to have_content(@c2.last_name)

    expect(page).to have_content(@c3.first_name)
    expect(page).to have_content(@c3.last_name)

    expect(page).to have_content(@c4.first_name)
    expect(page).to have_content(@c4.last_name)

    expect(page).to_not have_content(@c5.first_name)
  end

  it 'should display a number of successful transactions each top customer has with a merchant' do
    expect(page).to have_content(@c1.number_of_transactions)
  end

  it 'should display a list of Invoice IDs and Items that have not been shipped' do
    expect(page).to have_content(@i1.id)
    expect(page).to have_content(@i3.id)

    expect(page).to_not have_content(@i2.id)
  end

  it 'should link to the invoice admin show page via id' do
    expect(page).to have_link("Invoice # #{@i1.id}")
    click_link("Invoice # #{@i1.id}")

    expect(current_path).to eq(admin_invoice_path(@i1))
  end
end
