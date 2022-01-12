require 'rails_helper'

RSpec.describe 'Admin Dashboard Page' do

  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson')}

  let!(:item_1) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100, status: 0)}
  let!(:item_2) {merchant_1.items.create!(name: "Bracelet", description: "A thing around your neck", unit_price: 100, status: 0)}
  let!(:item_3) {merchant_1.items.create!(name: "Earrings", description: "A thing around your neck", unit_price: 100, status: 0)}
  let!(:item_4) {merchant_1.items.create!(name: "Gauges", description: "A thing around your neck", unit_price: 100, status: 1)}
  let!(:item_5) {merchant_1.items.create!(name: "Plants", description: "A thing around your neck", unit_price: 100)}

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

  let!(:invoice_item_1) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: 0)}
  let!(:invoice_item_2) {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: 0)}
  let!(:invoice_item_3) {InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: 0)}
  let!(:invoice_item_4) {InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, status: 1)}
  let!(:invoice_item_5) {InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, status: 1)}

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
    visit admin_dashboard_index_path
  end

  scenario 'visitor sees a header' do
    expect(page).to have_content("Admin Dashboard")
  end

  scenario 'visitor sees a link to the admin merchant index page' do
    expect(page).to have_link("Merchants", href: admin_merchants_path)
  end

  scenario 'visitor sees a link to the admin invoices index page' do
    expect(page).to have_link("Invoices", href: admin_invoices_path)
  end

  scenario 'visitor sees top 5 customers' do
    expect(page).to have_content(customer_1.first_name)
    expect(page).to have_content(customer_1.last_name)
    expect(page).to have_content(customer_2.first_name)
    expect(page).to have_content(customer_3.first_name)
    expect(page).to have_content(customer_4.first_name)
    expect(page).to have_content(customer_5.first_name)
    expect(page).to have_no_content(customer_6.first_name)
  end

  scenario 'visitor sees number of successful transactions next to each customer' do
    within "#customer#{Customer.top_5.first.id}" do
      expect(page).to have_content(Customer.top_5.first.transaction_count)
    end

    within "#customer#{Customer.top_5[1].id}" do
      expect(page).to have_content(Customer.top_5[1].transaction_count)
    end

    within "#customer#{Customer.top_5[2].id}" do
      expect(page).to have_content(Customer.top_5[2].transaction_count)
    end

    within "#customer#{Customer.top_5[3].id}" do
      expect(page).to have_content(Customer.top_5[3].transaction_count)
    end

    within "#customer#{Customer.top_5[4].id}" do
      expect(page).to have_content(Customer.top_5[4].transaction_count)
    end
  end

  describe 'incomplete invoices section' do
    scenario 'admin sees section for incomplete invoices' do
      expect(page).to have_content('Incomplete Invoices')
    end

    scenario 'incomplete invoices show all invoice ids with items that have not been shipped' do
      within "#incomplete-invoices" do
        expect(page).to have_content(invoice_1.id)
        expect(page).to have_content(invoice_2.id)
        expect(page).to have_content(invoice_3.id)
        expect(page).to have_content(invoice_4.id)
        expect(page).to have_content(invoice_5.id)
      end
    end

    scenario 'each invoice id links to the invoice admin show' do
      within "#incomplete-invoices" do
        expect(page).to have_link("#{invoice_1.id}", href: admin_invoice_path(invoice_1.id))
        expect(page).to have_link("#{invoice_2.id}", href: admin_invoice_path(invoice_2.id))
        expect(page).to have_link("#{invoice_3.id}", href: admin_invoice_path(invoice_3.id))
        expect(page).to have_link("#{invoice_4.id}", href: admin_invoice_path(invoice_4.id))
        expect(page).to have_link("#{invoice_5.id}", href: admin_invoice_path(invoice_5.id))
      end
    end

    scenario 'visitor sees invoice creation date next to each invoice' do
      within "#incomplete-invoices-#{invoice_1.id}" do
        expect(page).to have_content(invoice_1.creation_date_formatted)
      end

      within "#incomplete-invoices-#{invoice_2.id}" do
        expect(page).to have_content(invoice_2.creation_date_formatted)
      end
    end

    scenario 'visitor sees invoices are ordered from oldest to newest' do
      first = find("#incomplete-invoices-#{invoice_1.id}")
      second = find("#incomplete-invoices-#{invoice_4.id}")
      third = find("#incomplete-invoices-#{invoice_5.id}")
      fourth = find("#incomplete-invoices-#{invoice_2.id}")
      fifth = find("#incomplete-invoices-#{invoice_3.id}")

      within "#incomplete-invoices" do
        expect(first).to appear_before(second)
        expect(second).to appear_before(third)
        expect(third).to appear_before(fourth)
        expect(fourth).to appear_before(fifth)
      end
    end
  end
end
