require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson', status: 0)}
  let!(:merchant_2) {Merchant.create!(name: 'Leslie Knope', status: 0)}
  let!(:merchant_3) {Merchant.create!(name: 'Oprah Winfrey', status: 0)}
  let!(:merchant_4) {Merchant.create!(name: 'Leonardo Dicaprio')}
  let!(:merchant_5) {Merchant.create!(name: 'Steve Carell')}
  let!(:merchant_6) {Merchant.create!(name: 'Jenna Fischer')}

  let!(:item_1) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 1000, status: 0)}
  let!(:item_2) {merchant_2.items.create!(name: "Bracelet", description: "A thing around your wrist", unit_price: 900, status: 0)}
  let!(:item_3) {merchant_3.items.create!(name: "Earrings", description: "These go through your ears", unit_price: 1500, status: 1)}
  let!(:item_4) {merchant_4.items.create!(name: "Ring", description: "A thing around your finger", unit_price: 1000)}
  let!(:item_5) {merchant_5.items.create!(name: "Toe Ring", description: "A thing around your neck", unit_price: 800)}
  let!(:item_6) {merchant_6.items.create!(name: "Pendant", description: "A thing to put somewhere", unit_price: 1500)}

  let!(:customer_1) {Customer.create!(first_name: "Billy", last_name: "Joel")}

  let!(:invoice_1) {customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')}
  let!(:invoice_2) {customer_1.invoices.create!(status: 1, created_at: '2012-04-25 08:54:09')}
  let!(:invoice_3) {customer_1.invoices.create!(status: 1, created_at: '2012-10-25 04:54:09')}
  let!(:invoice_4) {customer_1.invoices.create!(status: 1, created_at: '2012-03-26 01:54:09')}
  let!(:invoice_5) {customer_1.invoices.create!(status: 1, created_at: '2012-03-28 12:54:09')}
  let!(:invoice_6) {customer_1.invoices.create!(status: 1, created_at: '2012-03-29 07:54:09')}
  let!(:invoice_7) {customer_1.invoices.create!(status: 1, created_at: '2013-03-25 09:54:09')}
  let!(:invoice_8) {customer_1.invoices.create!(status: 1, created_at: '2013-04-25 08:54:09')}
  let!(:invoice_9) {customer_1.invoices.create!(status: 1, created_at: '2013-10-25 04:54:09')}
  let!(:invoice_10) {customer_1.invoices.create!(status: 1, created_at: '2013-03-26 01:54:09')}

  let!(:invoice_item_1)  {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, unit_price: 1000, quantity: 2, status: 0)}
  let!(:invoice_item_2)  {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, unit_price: 1000, quantity: 26, status: 0)}
  let!(:invoice_item_3)  {InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, unit_price: 1000, quantity: 2, status: 0)}
  let!(:invoice_item_4)  {InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, unit_price: 1000, quantity: 4, status: 1)}
  let!(:invoice_item_5)  {InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, unit_price: 1000, quantity: 40, status: 1)}
  let!(:invoice_item_6)  {InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, unit_price: 1000, quantity: 7, status: 2)}

  let!(:invoice_item_7)  {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_7.id, unit_price: 1000, quantity: 2, status: 0)}
  let!(:invoice_item_8)  {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_8.id, unit_price: 1000, quantity: 13, status: 0)}
  let!(:invoice_item_9)  {InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_9.id, unit_price: 1000, quantity: 4, status: 0)}
  let!(:invoice_item_10)  {InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_10.id, unit_price: 1000, quantity: 8, status: 1)}

  let!(:transaction_1) {invoice_1.transactions.create!(result: 'success')}
  let!(:transaction_2) {invoice_2.transactions.create!(result: 'success')}
  let!(:transaction_3) {invoice_3.transactions.create!(result: 'success')}
  let!(:transaction_4) {invoice_4.transactions.create!(result: 'success')}
  let!(:transaction_5) {invoice_5.transactions.create!(result: 'success')}
  let!(:transaction_6) {invoice_6.transactions.create!(result: 'success')}
  let!(:transaction_7) {invoice_7.transactions.create!(result: 'success')}
  let!(:transaction_8) {invoice_8.transactions.create!(result: 'success')}
  let!(:transaction_9) {invoice_9.transactions.create!(result: 'failed')}
  let!(:transaction_10) {invoice_10.transactions.create!(result: 'success')}

  before(:each) do
   visit admin_merchants_path
  end

  scenario 'visitor sees the names of each merchant in the system' do
    expect(page).to have_content(merchant_1.name)
    expect(page).to have_content(merchant_2.name)
    expect(page).to have_content(merchant_3.name)
    expect(page).to have_content(merchant_4.name)
  end

  scenario 'visitor sees button to disable or enable each merchant next to their name' do
    within("#enabled_merchant-#{merchant_1.id}") do
      expect(page).to have_button("Disable")
    end

    within("#enabled_merchant-#{merchant_2.id}") do
      expect(page).to have_button("Disable")
    end

    within("#enabled_merchant-#{merchant_3.id}") do
      expect(page).to have_button("Disable")
    end

    within("#disabled_merchant-#{merchant_4.id}") do
      expect(page).to have_button("Enable")
    end
  end

  scenario 'visitor clicks button and is redirected back to the same page, where they see the Merchant status change' do
    within("#enabled_merchant-#{merchant_1.id}") do
      click_button("Disable")
      expect(current_path).to eq(admin_merchants_path)
    end

    within("#disabled") do
      expect(page).to have_content(merchant_1.name)
    end

    within("#disabled_merchant-#{merchant_1.id}") do
      click_button("Enable")
      expect(current_path).to eq(admin_merchants_path)
    end

    within("#enabled") do
      expect(page).to have_content(merchant_1.name)
    end
  end

  scenario 'visitor sees link to create a new merchant' do
    expect(page).to have_link("New Merchant")
  end

  scenario 'visitor clicks link to go to form to add merchant information' do
    click_link "New Merchant"
    expect(current_path).to eq(new_admin_merchant_path)
    expect(page).to have_field('Name')
    expect(page).to have_button("Submit")
  end

  scenario 'visitor fills out form, clicks Submit, and is redirected to the index page to see the new merchant' do
    visit new_admin_merchant_path
    fill_in 'Name', with: "Newest Merchant"
    click_button "Submit"

    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content("Newest Merchant")
  end

  scenario 'visitor sees that the new merchant was created with a default status of disabled' do
    visit new_admin_merchant_path
    fill_in 'Name', with: "Newest Merchant"
    click_button "Submit"

    expect(current_path).to eq(admin_merchants_path)
    within("#disabled") do
      expect(page).to have_content('Newest Merchant')
    end
  end

  scenario 'visitor sees list of top 5 merchants ordered by total revenue' do
    first = find("#merchant#{merchant_5.id}")
    second = find("#merchant#{merchant_2.id}")
    third = find("#merchant#{merchant_4.id}")
    fourth = find("#merchant#{merchant_6.id}")
    fifth = find("#merchant#{merchant_1.id}")
    expect(first).to appear_before(second)
    expect(second).to appear_before(third)
    expect(third).to appear_before(fourth)
    expect(fourth).to appear_before(fifth)
  end

  scenario 'visitor sees the top 5 merchant names as links to their respective show pages' do
    within "#merchant#{merchant_5.id}" do
      expect(page).to have_link("#{merchant_5.name}", href: admin_merchant_path(merchant_5.id))
    end

    within "#merchant#{merchant_2.id}" do
      expect(page).to have_link("#{merchant_2.name}", href: admin_merchant_path(merchant_2.id))
    end

    within "#merchant#{merchant_4.id}" do
      expect(page).to have_link("#{merchant_4.name}", href: admin_merchant_path(merchant_4.id))
    end

    within "#merchant#{merchant_6.id}" do
      expect(page).to have_link("#{merchant_6.name}", href: admin_merchant_path(merchant_6.id))
    end

    within "#merchant#{merchant_1.id}" do
      expect(page).to have_link("#{merchant_1.name}", href: admin_merchant_path(merchant_1.id))
    end
  end

  scenario 'visitor sees the total_revenue generated next to each merchant name' do
    within "#merchant#{merchant_5.id}" do
      expect(page).to have_content(Merchant.top_five_merchants.first.total_revenue.to_f/100)
    end

    within "#merchant#{merchant_2.id}" do
      expect(page).to have_content(Merchant.top_five_merchants[1].total_revenue.to_f/100)
    end

    within "#merchant#{merchant_4.id}" do
      expect(page).to have_content(Merchant.top_five_merchants[2].total_revenue.to_f/100)
    end

    within "#merchant#{merchant_6.id}" do
      expect(page).to have_content(Merchant.top_five_merchants[3].total_revenue.to_f/100)
    end

    within "#merchant#{merchant_1.id}" do
      expect(page).to have_content(Merchant.top_five_merchants[4].total_revenue.to_f/100)
    end
  end

  scenario 'visitor sees the date with most revenue for each merchant' do
    within "#merchant#{merchant_5.id}" do
      expect(page).to have_content(Merchant.top_five_merchants.first.top_date)
    end

    within "#merchant#{merchant_2.id}" do
      expect(page).to have_content(Merchant.top_five_merchants[1].top_date)
    end

    within "#merchant#{merchant_4.id}" do
      expect(page).to have_content(Merchant.top_five_merchants[2].top_date)
    end

    within "#merchant#{merchant_6.id}" do
      expect(page).to have_content(Merchant.top_five_merchants[3].top_date)
    end

    within "#merchant#{merchant_1.id}" do
      expect(page).to have_content(Merchant.top_five_merchants[4].top_date)
    end
  end

  scenario 'visitor sees the most recent date if multiple days had the same revenue' do
    within "#merchant#{merchant_1.id}" do
      expect(page).to have_content('03/25/13')
    end
  end
end
