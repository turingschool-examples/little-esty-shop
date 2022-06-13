require 'rails_helper'

RSpec.describe 'The Admin Dashboard Index' do
  before :each do
    @merchant2 = Merchant.create!(name: 'Juan Lopez')

    @item1 = @merchant2.items.create!(name: 'cheese', description: 'european cheese', unit_price: 2400, item_status: 1)
    @item2 = @merchant2.items.create!(name: 'onion', description: 'red onion', unit_price: 3450, item_status: 1)
    @item3 = @merchant2.items.create!(name: 'earing', description: 'Lotus earings', unit_price: 14_500)
    @item4 = @merchant2.items.create!(name: 'bracelet', description: 'Silver bracelet', unit_price: 76_000,
                                      item_status: 1)
    @item5 = @merchant2.items.create!(name: 'ring', description: 'lotus ring', unit_price: 2345)
    @item6 = @merchant2.items.create!(name: 'skirt', description: 'Hoop skirt', unit_price: 2175, item_status: 1)
    @item7 = @merchant2.items.create!(name: 'shirt', description: "Mike's Yellow Shirt", unit_price: 5405,
                                      item_status: 1)
    @item8 = @merchant2.items.create!(name: 'socks', description: 'Cat Socks', unit_price: 934)

    @customer1 = Customer.create!(first_name: 'Fred', last_name: 'Dunce')
    @customer2 = Customer.create!(first_name: 'Sal', last_name: 'Dali')
    @customer3 = Customer.create!(first_name: 'Earny', last_name: 'Hemi')
    @customer4 = Customer.create!(first_name: 'Jack', last_name: 'Wack')
    @customer5 = Customer.create!(first_name: 'Mack', last_name: 'Aurther')
    @customer6 = Customer.create!(first_name: 'Charly', last_name: 'Dicky')

    @invoice1 = Invoice.create!(status: 2, customer_id: @customer1.id)
    @invoice2 = Invoice.create!(status: 2, customer_id: @customer1.id)
    @invoice3 = Invoice.create!(status: 2, customer_id: @customer2.id)
    @invoice4 = Invoice.create!(status: 2, customer_id: @customer3.id)
    @invoice5 = Invoice.create!(status: 2, customer_id: @customer4.id)
    @invoice6 = Invoice.create!(status: 2, customer_id: @customer5.id)
    @invoice7 = Invoice.create!(status: 2, customer_id: @customer6.id)

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 3, unit_price: 2400,
                                         status: 1)
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 3450,
                                         status: 0)
    @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 14_500,
                                         status: 2)
    @invoice_item4 = InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice4.id, quantity: 2, unit_price: 5405,
                                         status: 2)
    @invoice_item5 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice5.id, quantity: 1, unit_price: 14_500,
                                         status: 2)
    @invoice_item6 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice6.id, quantity: 1, unit_price: 76_000,
                                         status: 2)
    @invoice_item7 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 2175,
                                         status: 2)
    @invoice_item8 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice1.id, quantity: 4, unit_price: 934,
                                         status: 2)
    @invoice_item9 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 3450,
                                         status: 2)
    @invoice_item10 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 76_000,
                                          status: 2)
    @invoice_item11 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice4.id, quantity: 2, unit_price: 2400,
                                          status: 2)
    @invoice_item12 = InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice5.id, quantity: 3, unit_price: 2345,
                                          status: 2)
    @invoice_item13 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice7.id, quantity: 5, unit_price: 2175,
                                          status: 2)
    @invoice_item14 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice7.id, quantity: 7, unit_price: 934,
                                          status: 2)
    @invoice_item15 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 2, unit_price: 2400,
                                          status: 2)
    @invoice_item16 = InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 5405,
                                          status: 2)
    @invoice_item17 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 2175,
                                          status: 2)
    @invoice_item18 = InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice4.id, quantity: 2, unit_price: 2345,
                                          status: 2)
    @invoice_item19 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice4.id, quantity: 1, unit_price: 76_000,
                                          status: 2)
    @invoice_item20 = InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 5405,
                                          status: 2)

    @transaction1 = Transaction.create!(result: 0, invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(result: 0, invoice_id: @invoice2.id)
    @transaction3 = Transaction.create!(result: 0, invoice_id: @invoice3.id)
    @transaction4 = Transaction.create!(result: 1, invoice_id: @invoice3.id)
    @transaction5 = Transaction.create!(result: 0, invoice_id: @invoice4.id)
    @transaction6 = Transaction.create!(result: 0, invoice_id: @invoice5.id)
    @transaction7 = Transaction.create!(result: 0, invoice_id: @invoice6.id)
    @transaction8 = Transaction.create!(result: 1, invoice_id: @invoice7.id)
  end

  it 'displays a header that reads Admin Dashboard' do
    visit admin_dashboard_index_path
    expect(page).to have_content('Admin Dashboard')
  end

  it 'can see link to admin merchant index' do
    visit admin_dashboard_index_path
    expect(page).to have_link('Admin merchants index')
  end

  it 'can see link to admin merchant index' do
    visit admin_dashboard_index_path
    expect(page).to have_link('Admin invoices index')
  end

  it 'can see the names of the top 5 customers with successful transactions' do
    visit admin_dashboard_index_path
    expect(page).to have_content("#{@customer1.first_name} #{@customer1.last_name}")
    expect(page).to have_content("#{@customer2.first_name} #{@customer2.last_name}")
    expect(page).to have_content("#{@customer3.first_name} #{@customer3.last_name}")
    expect(page).to have_content("#{@customer4.first_name} #{@customer4.last_name}")
    expect(page).to have_content("#{@customer5.first_name} #{@customer5.last_name}")
  end

  it 'can see a section for "Incomplete Invoices"' do
    visit admin_dashboard_index_path
    not_shipped_invoices = Invoice.not_shipped

    expect(page).to have_content('Incomplete Invoices')

    expect(page).to have_content("#{not_shipped_invoices.first.id}")
    expect(page).to have_content("#{not_shipped_invoices.last.id}")
    expect(page).to_not have_content(@invoice5.id)
    expect(page).to have_link(@invoice1.id)
  end
end
