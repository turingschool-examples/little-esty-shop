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
    customer_1 = create(:customer, first_name: 'Bob', last_name: "Smith")
    customer_2 = create(:customer, first_name: 'John', last_name: "Charles")
    customer_3 = create(:customer, first_name: 'Abe', last_name: "McConnel")
    customer_4 = create(:customer, first_name: 'Zach', last_name: "Doe")
    customer_5 = create(:customer, first_name: 'Charlie', last_name: "Rey")

    merchant_1 = create(:merchant_with_transactions, transaction_count: 6, customer: customer_1, transaction_result: 0)
    merchant_2 = create(:merchant_with_transactions, transaction_count: 3, customer: customer_2, transaction_result: 0)
    merchant_3 = create(:merchant_with_transactions, transaction_count: 8, customer: customer_3, transaction_result: 0)
    merchant_4 = create(:merchant_with_transactions, transaction_count: 1, customer: customer_4, transaction_result: 0)
    merchant_5 = create(:merchant_with_transactions, transaction_count: 4, customer: customer_5, transaction_result: 0)
    visit "/admin"
    expect(page).to have_content("Top 5 Customers")

    expect('Abe McConnel').to appear_before('Bob Smith')
    expect('Bob Smith').to appear_before('Charlie Rey')
    expect('Charlie Rey').to appear_before('John Charles')
    expect('John Charles').to appear_before('Zach Doe')
    
    expect(page).to have_content("Abe McConnel with 8 completed transactions")
    expect(page).to have_content("Zach Doe with 1 completed transactions")
  end

  it 'shows incomplete invoices with all invoice ids as well as links to their show page' do
    invoice_1 = create(:invoice, status: 0)
    invoice_2 = create(:invoice, status: 0)
    invoice_3 = create(:invoice, status: 2)
    visit "/admin"

    expect(page).to have_content("Incomplete Invoices")
    expect(page).to have_content(invoice_1.id)
    expect(page).to have_link(invoice_2.id)
    expect(page).to_not have_content(invoice_3.id)
  end

  it 'shows the created at dates in order of oldest to newest' do
    invoice_1 = create(:invoice, created_at: "2022-01-06")
    invoice_2 = create(:invoice, created_at: "2022-01-05")
    invoice_3 = create(:invoice, created_at: "2022-01-04")
    invoice_4 = create(:invoice, created_at: "2022-01-03")

    visit "/admin"
    
    expect("Incomplete Invoices").to appear_before("Monday, January 03, 2022")
    expect("Monday, January 03, 2022").to appear_before("Tuesday, January 04, 2022")
    expect("Tuesday, January 04, 2022").to appear_before("Wednesday, January 05, 2022")
    expect("Wednesday, January 05, 2022").to appear_before("Thursday, January 06, 2022")
  end
end
