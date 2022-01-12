require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do

  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson')}

  let!(:item_1) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100, status: 0)}
  let!(:item_2) {merchant_1.items.create!(name: "Bracelet", description: "A thing around your neck", unit_price: 100, status: 0)}
  let!(:item_3) {merchant_1.items.create!(name: "Earrings", description: "A thing around your neck", unit_price: 100, status: 0)}
  let!(:item_4) {merchant_1.items.create!(name: "Gauges", description: "A thing around your neck", unit_price: 100, status: 1)}
  let!(:item_5) {merchant_1.items.create!(name: "Plants", description: "A thing around your neck", unit_price: 100)}
  let!(:item_6) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_7) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_8) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_9) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_10) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_11) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_12) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_13) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_14) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_15) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}

  let!(:customer_1) {Customer.create!(first_name: "Billy", last_name: "Joel")}
  let!(:customer_2) {Customer.create!(first_name: "Britney", last_name: "Spears")}
  let!(:customer_3) {Customer.create!(first_name: "Prince", last_name: "Mononym")}
  let!(:customer_4) {Customer.create!(first_name: "Garfunkle", last_name: "Oates")}
  let!(:customer_5) {Customer.create!(first_name: "Rick", last_name: "James")}
  let!(:customer_6) {Customer.create!(first_name: "Dave", last_name: "Chappelle")}

  let!(:invoice_1) {customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')}
  let!(:invoice_2) {customer_2.invoices.create!(status: 1, created_at: '2012-04-25 08:54:09')}
  let!(:invoice_3) {customer_3.invoices.create!(status: 1, created_at: '2012-10-25 04:54:09')}
  let!(:invoice_4) {customer_4.invoices.create!(status: 1, created_at: '2012-03-26 01:54:09')}
  let!(:invoice_5) {customer_1.invoices.create!(status: 1, created_at: '2012-03-28 12:54:09')}
  let!(:invoice_6) {customer_2.invoices.create!(status: 1, created_at: '2012-03-29 07:54:09')}
  let!(:invoice_7) {customer_3.invoices.create!(status: 1)}
  let!(:invoice_8) {customer_4.invoices.create!(status: 1)}
  let!(:invoice_9) {customer_1.invoices.create!(status: 1)}
  let!(:invoice_10) {customer_1.invoices.create!(status: 1)}
  let!(:invoice_11) {customer_3.invoices.create!(status: 1)}
  let!(:invoice_12) {customer_3.invoices.create!(status: 1)}
  let!(:invoice_13) {customer_4.invoices.create!(status: 1)}
  let!(:invoice_14) {customer_4.invoices.create!(status: 1)}
  let!(:invoice_15) {customer_5.invoices.create!(status: 1)}

  let!(:invoice_item_1) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, unit_price: item_1.unit_price, quantity: 2, status: 0)}
  let!(:invoice_item_2) {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, unit_price: item_2.unit_price, quantity: 2, status: 0)}
  let!(:invoice_item_3) {InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, unit_price: item_3.unit_price, quantity: 2, status: 0)}
  let!(:invoice_item_4) {InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, unit_price: item_4.unit_price, quantity: 2, status: 1)}
  let!(:invoice_item_5) {InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, unit_price: item_5.unit_price, quantity: 2, status: 1)}
  let!(:invoice_item_6) {InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, unit_price: item_6.unit_price, quantity: 2, status: 2)}
  let!(:invoice_item_7) {InvoiceItem.create!(item_id: item_7.id, invoice_id: invoice_7.id, unit_price: item_7.unit_price, quantity: 2, status: 2)}
  let!(:invoice_item_8) {InvoiceItem.create!(item_id: item_8.id, invoice_id: invoice_8.id, unit_price: item_8.unit_price, quantity: 2, status: 2)}
  let!(:invoice_item_9) {InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_9.id, unit_price: item_9.unit_price, quantity: 2, status: 2)}
  let!(:invoice_item_10) {InvoiceItem.create!(item_id: item_10.id, invoice_id: invoice_10.id, unit_price: item_10.unit_price, quantity: 2, status: 2)}
  let!(:invoice_item_11) {InvoiceItem.create!(item_id: item_11.id, invoice_id: invoice_11.id, unit_price: item_11.unit_price, quantity: 2, status: 2)}
  let!(:invoice_item_12) {InvoiceItem.create!(item_id: item_12.id, invoice_id: invoice_12.id, unit_price: item_12.unit_price, quantity: 2, status: 2)}
  let!(:invoice_item_13) {InvoiceItem.create!(item_id: item_13.id, invoice_id: invoice_13.id, unit_price: item_13.unit_price, quantity: 2, status: 2)}
  let!(:invoice_item_14) {InvoiceItem.create!(item_id: item_14.id, invoice_id: invoice_14.id, unit_price: item_14.unit_price, quantity: 2, status: 2)}
  let!(:invoice_item_15) {InvoiceItem.create!(item_id: item_15.id, invoice_id: invoice_15.id, unit_price: item_15.unit_price, quantity: 2, status: 2)}

  let!(:transaction_1) {invoice_1.transactions.create!(result: 'success')}
  let!(:transaction_2) {invoice_2.transactions.create!(result: 'success')}
  let!(:transaction_3) {invoice_3.transactions.create!(result: 'success')}
  let!(:transaction_4) {invoice_4.transactions.create!(result: 'success')}
  let!(:transaction_5) {invoice_5.transactions.create!(result: 'success')}
  let!(:transaction_6) {invoice_6.transactions.create!(result: 'success')}
  let!(:transaction_7) {invoice_7.transactions.create!(result: 'success')}
  let!(:transaction_8) {invoice_8.transactions.create!(result: 'success')}
  let!(:transaction_9) {invoice_9.transactions.create!(result: 'success')}
  let!(:transaction_10) {invoice_10.transactions.create!(result: 'success')}
  let!(:transaction_11) {invoice_11.transactions.create!(result: 'success')}
  let!(:transaction_12) {invoice_12.transactions.create!(result: 'success')}
  let!(:transaction_13) {invoice_13.transactions.create!(result: 'success')}
  let!(:transaction_14) {invoice_14.transactions.create!(result: 'success')}
  let!(:transaction_15) {invoice_15.transactions.create!(result: 'success')}

  before(:each) do
    visit "/merchants/#{merchant_1.id}/dashboard"
  end

  scenario 'visitor sees the name of my merchant' do
    expect(page).to have_content(merchant_1.name)
  end

  scenario 'visitor sees link to merchant item index' do
    expect(page).to have_link("My items", href: merchant_items_path(merchant_1.id))
  end

  scenario 'visitor sees link to merchant invoices index' do
    expect(page).to have_link("My invoices", href: merchant_invoices_path(merchant_1.id))
  end

  scenario 'visitor sees top 5 customers associated with merchant' do
    expect(page).to have_content(customer_1.first_name)
    expect(page).to have_content(customer_1.last_name)
    expect(page).to have_content(customer_2.first_name)
    expect(page).to have_content(customer_3.first_name)
    expect(page).to have_content(customer_4.first_name)
    expect(page).to have_content(customer_5.first_name)
    expect(page).to have_no_content(customer_6.first_name)
  end

  scenario 'visitor sees number of successful transactions next to each customer' do
    within "#customer#{merchant_1.top_5_customers.first.id}" do
      expect(page).to have_content(merchant_1.top_5_customers.first.transaction_count)
    end

    within "#customer#{merchant_1.top_5_customers[1].id}" do
      expect(page).to have_content(merchant_1.top_5_customers[1].transaction_count)
    end

    within "#customer#{merchant_1.top_5_customers[2].id}" do
      expect(page).to have_content(merchant_1.top_5_customers[2].transaction_count)
    end

    within "#customer#{merchant_1.top_5_customers[3].id}" do
      expect(page).to have_content(merchant_1.top_5_customers[3].transaction_count)
    end

    within "#customer#{merchant_1.top_5_customers[4].id}" do
      expect(page).to have_content(merchant_1.top_5_customers[4].transaction_count)
    end
  end

  describe 'in items ready to ship section' do
    scenario 'visitor sees a list of item names that have not been shipped' do
      expect(page).to have_content("Items Ready to Ship")

      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_3.name)
      expect(page).to have_content(item_4.name)
      expect(page).to have_content(item_5.name)
    end

    scenario 'visitor sees the invoice id next to the item name' do

      expect(page).to have_link("#{invoice_item_1.invoice_id}", href: merchant_invoice_path(merchant_1.id, invoice_1.id))
      expect(page).to have_link("#{invoice_item_2.invoice_id}", href: merchant_invoice_path(merchant_1.id, invoice_2.id))
      expect(page).to have_link("#{invoice_item_3.invoice_id}", href: merchant_invoice_path(merchant_1.id, invoice_3.id))
      expect(page).to have_link("#{invoice_item_4.invoice_id}", href: merchant_invoice_path(merchant_1.id, invoice_4.id))
      expect(page).to have_link("#{invoice_item_5.invoice_id}", href: merchant_invoice_path(merchant_1.id, invoice_5.id))
    end

    scenario 'visitor sees date of invoice creation next to each item' do
      expect(page).to have_content(invoice_1.created_at.strftime("%A, %B %d,%Y"))
      expect(page).to have_content(invoice_2.created_at.strftime("%A, %B %d,%Y"))
      expect(page).to have_content(invoice_3.created_at.strftime("%A, %B %d,%Y"))
      expect(page).to have_content(invoice_4.created_at.strftime("%A, %B %d,%Y"))
      expect(page).to have_content(invoice_5.created_at.strftime("%A, %B %d,%Y"))
    end

    scenario 'visitor sees list ordered from oldest to newest' do
      first = find("#item#{item_1.id}")
      second = find("#item#{item_4.id}")
      third = find("#item#{item_5.id}")
      fourth = find("#item#{item_2.id}")
      fifth = find("#item#{item_3.id}")
      expect(first).to appear_before(second)
      expect(second).to appear_before(third)
      expect(third).to appear_before(fourth)
      expect(fourth).to appear_before(fifth)
    end
  end
end
