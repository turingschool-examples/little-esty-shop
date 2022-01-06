require 'rails_helper'

RSpec.describe 'The Admin Dashboard page' do
  it 'shows a header to notify the dashboard' do
    visit "/admin"

    expect(page).to have_content("Admin Dashboard")
  end

  it 'shows links to access merchant and invoice index' do
    visit "/admin"

    expect(page).to have_link("Merchants Index")
    expect(page).to have_link("Invoices Index")
  end

  it 'shows the names of the top 5 customers ' do
    customer_1 = create(:customer, first_name: 'Bob')
    customer_2 = create(:customer, first_name: 'John')
    customer_3 = create(:customer, first_name: 'Abe')
    customer_4 = create(:customer, first_name: 'Zach')
    customer_5 = create(:customer, first_name: 'Charlie')

    merchant_1 = create(:merchant_with_invoices, invoice_count: 6, customer: customer_1, invoice_status: 2)
    merchant_2 = create(:merchant_with_invoices, invoice_count: 3, customer: customer_2, invoice_status: 2)
    merchant_3 = create(:merchant_with_invoices, invoice_count: 8, customer: customer_3, invoice_status: 2)
    merchant_4 = create(:merchant_with_invoices, invoice_count: 1, customer: customer_4, invoice_status: 2)
    merchant_5 = create(:merchant_with_invoices, invoice_count: 4, customer: customer_5, invoice_status: 2)

    visit "/admin"
    expect(page).to have_content("Top 5 Customers")

    expect('Abe').to appear_before('Bob')
    expect('Bob').to appear_before('Charlie')
    expect('Charlie').to appear_before('John')
    expect('John').to appear_before('Zach')

    expect(page).to have_content("Abe Completed Transactions: 8")
    expect(page).to have_content("Zach Completed Transactions: 8")
  end 
end
