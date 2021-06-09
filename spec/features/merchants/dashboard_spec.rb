require 'rails_helper'

RSpec.describe 'merchant dashboard' do
  before(:each) do
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @antimerchant = Merchant.create!(name: 'TheOtherOne')

    @customer_1 = Customer.create!(first_name: 'John', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Julie', last_name: 'Baker')
    @customer_3 = Customer.create!(first_name: 'Jared', last_name: 'Lanata')
    @customer_4 = Customer.create!(first_name: 'Jira', last_name: 'Mutiu')
    @customer_5 = Customer.create!(first_name: 'Josephina', last_name: 'Cortez')
    @customer_6 = Customer.create!(first_name: 'Jemma', last_name: 'Henry')

    @item_1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant.id)
    @item_3 = Item.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 19.4, merchant_id: @merchant.id)
    @item_4 = Item.create!(name: 'Thing 4', description: 'This is the fourth thing.', unit_price: 12.2, merchant_id: @merchant.id)
    @item_5 = Item.create!(name: 'Thing 5', description: 'This is the fifth thing.', unit_price: 15.3, merchant_id: @merchant.id)
    @item_6 = Item.create!(name: 'Thing 6', description: 'This is the sixth thing.', unit_price: 10.4, merchant_id: @antimerchant.id)

    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer_1.id, created_at: "2021-06-05 20:11:38.553871")
    @invoice_2 = Invoice.create!(status: 1, customer_id: @customer_2.id, created_at: "2021-06-07 20:11:38.553871")
    @invoice_3 = Invoice.create!(status: 1, customer_id: @customer_3.id, created_at: "2021-06-06 20:11:38.553871")
    @invoice_4 = Invoice.create!(status: 1, customer_id: @customer_4.id, created_at: "2021-06-01 20:11:38.553871")
    @invoice_5 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: "2021-06-02 20:11:38.553871")
    @invoice_6 = Invoice.create!(status: 1, customer_id: @customer_6.id, created_at: "2021-06-03 20:11:38.553871")

    @invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 2, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 5, unit_price: 16.3, status: 1, invoice_id: @invoice_1.id, item_id: @item_2.id)
    @invoice_item_3 = InvoiceItem.create!(quantity: 4, unit_price: 19.4, status: 2, invoice_id: @invoice_2.id, item_id: @item_3.id)
    @invoice_item_4 = InvoiceItem.create!(quantity: 1, unit_price: 12.2, status: 2, invoice_id: @invoice_2.id, item_id: @item_4.id)
    @invoice_item_5 = InvoiceItem.create!(quantity: 2, unit_price: 10.4, status: 2, invoice_id: @invoice_2.id, item_id: @item_2.id)
    @invoice_item_6 = InvoiceItem.create!(quantity: 7, unit_price: 15.3, status: 1, invoice_id: @invoice_3.id, item_id: @item_5.id)
    @invoice_item_7 = InvoiceItem.create!(quantity: 6, unit_price: 10.4, status: 2, invoice_id: @invoice_3.id, item_id: @item_3.id)
    @invoice_item_8 = InvoiceItem.create!(quantity: 3, unit_price: 19.4, status: 1, invoice_id: @invoice_4.id, item_id: @item_3.id)
    @invoice_item_9 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 1, invoice_id: @invoice_4.id, item_id: @item_5.id)
    @invoice_item_10 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 2, invoice_id: @invoice_6.id, item_id: @item_6.id)
    @invoice_item_11 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 1, invoice_id: @invoice_4.id, item_id: @item_1.id)
    @invoice_item_12 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 2, invoice_id: @invoice_4.id, item_id: @item_2.id)
  end

  it 'shows the name of the merchant in question' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_content("#{@merchant.name}")
    expect(page).to have_no_content("#{@antimerchant.name}")
  end

  xit 'has a link to my merchant items index' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_link("Merchant Items Index", href: "/merchants/#{@merchant.id}/items")
  end

  xit 'has a link to my merchant invoices index' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_link("Merchants Invoice Index", href: "/merchants/#{@merchant.id}/invoices")
  end

  xit 'has the top 5 customers names and how many transactions they have conducted with the merchant in question' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_content("Top 5 Customers:")
    expect(page).to have_content("#{@customer_1.name}")
    expect(page).to have_content("#{@customer_2.name}")
    expect(page).to have_content("#{@customer_3.name}")
    expect(page).to have_content("#{@customer_4.name}")
    expect(page).to have_content("#{@customer_5.name}")
    expect(page).to have_no_content("#{@customer_6.name}")

    within("##{@customer_1.id}") do
      expect(page).to have_content("Number of Transactions Conducted:")
      expect(page).to have_content("#{@customer_1.num_transactions_by_merchant}")
    end

    within("##{@customer_2.id}") do
      expect(page).to have_content("Number of Transactions Conducted:")
      expect(page).to have_content("#{@customer_2.num_transactions_by_merchant}")
    end

    within("##{@customer_3.id}") do
      expect(page).to have_content("Number of Transactions Conducted:")
      expect(page).to have_content("#{@customer_3.num_transactions_by_merchant}")
    end

    within("##{@customer_4.id}") do
      expect(page).to have_content("Number of Transactions Conducted:")
      expect(page).to have_content("#{@customer_4.num_transactions_by_merchant}")
    end

    within("##{@customer_5.id}") do
      expect(page).to have_content("Number of Transactions Conducted:")
      expect(page).to have_content("#{@customer_5.num_transactions_by_merchant}")
    end

    expect(page).to have_no_content("#{@customer_6.num_transactions_by_merchant}")
  end

  xit 'has a section to display all items that have been packaged but not yet shipped' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_content("Items Ready to Ship:")
    expect(page).to have_content("#{@invoice_item_2.item_name}")
    expect(page).to have_content("#{@invoice_item_8.item_name}")
    expect(page).to have_content("#{@invoice_item_9.item_name}")
    expect(page).to have_content("#{@invoice_item_11.item_name}")

  end

  xit 'does not show items that have been shipped' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_no_content("#{@invoice_item_4.item_name}")
    expect(page).to have_no_content("#{@invoice_item_6.item_name}")
  end

  xit 'has the invoice id of the item listed and it is a link to the invoice show page' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_link("#{@invoice_1.id}", href: "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}")
    expect(page).to have_no_link("#{@invoice_6.id}")
  end

  xit 'has the creation date listed by each invoice in oldest to newest order' do
    visit "/merchants/#{@merchant.id}/dashboard"

    within("##{@invoice_1.id}") do
      expect(page).to have_content("Saturday, June 05, 2021")
    end

    within("##{@invoice_2.id}") do
      expect(page).to have_content("Monday, June 07, 2021")
    end

    expect(page).to have_no_content("Thursday, June 03, 2021")

    #may need to change the ids to the dates associated with the invoices, in case of loose number messing up the tests
    expect("#{@invoice_4.id}").to appear_before("#{@invoice_5.id}")
    expect("#{@invoice_5.id}").to appear_before("#{@invoice_1.id}")
    expect("#{@invoice_1.id}").to appear_before("#{@invoice_3.id}")
    expect("#{@invoice_3.id}").to appear_before("#{@invoice_2.id}")
  end
end
