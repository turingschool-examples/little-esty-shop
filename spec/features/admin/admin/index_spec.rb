require 'rails_helper'

RSpec.describe 'admin index page' do
  let!(:customer_1) {FactoryBot.create(:customer)}
  let!(:customer_2) {FactoryBot.create(:customer)}
  let!(:customer_3) {FactoryBot.create(:customer)}
  let!(:customer_4) {FactoryBot.create(:customer)}
  let!(:customer_5) {FactoryBot.create(:customer)}
  let!(:customer_6) {FactoryBot.create(:customer)}

  let!(:invoice_1) {FactoryBot.create(:invoice, customer: customer_1, status: "in progress")}
  let!(:invoice_2) {FactoryBot.create(:invoice, customer: customer_2, status: "in progress")}
  let!(:invoice_3) {FactoryBot.create(:invoice, customer: customer_3, status: "in progress")}
  let!(:invoice_4) {FactoryBot.create(:invoice, customer: customer_4, status: "in progress")}
  let!(:invoice_5) {FactoryBot.create(:invoice, customer: customer_5, status: "in progress")}

  let!(:transaction_1) {FactoryBot.create(:transaction, invoice: invoice_1, result: "success")}
  let!(:transaction_2) {FactoryBot.create(:transaction, invoice: invoice_1, result: "success")}
  let!(:transaction_3) {FactoryBot.create(:transaction, invoice: invoice_1, result: "success")}

  let!(:transaction_4) {FactoryBot.create(:transaction, invoice: invoice_2, result: "success")}
  let!(:transaction_5) {FactoryBot.create(:transaction, invoice: invoice_2, result: "success")}
  let!(:transaction_6) {FactoryBot.create(:transaction, invoice: invoice_2, result: "success")}
  let!(:transaction_7) {FactoryBot.create(:transaction, invoice: invoice_2, result: "success")}
  let!(:transaction_8) {FactoryBot.create(:transaction, invoice: invoice_2, result: "success")}

  let!(:transaction_9) {FactoryBot.create(:transaction, invoice: invoice_3, result: "success")}

  let!(:transaction_10) {FactoryBot.create(:transaction, invoice: invoice_4, result: "success")}
  let!(:transaction_11) {FactoryBot.create(:transaction, invoice: invoice_4, result: "success")}
  let!(:transaction_12) {FactoryBot.create(:transaction, invoice: invoice_4, result: "success")}
  let!(:transaction_13) {FactoryBot.create(:transaction, invoice: invoice_4, result: "success")}

  let!(:transaction_14) {FactoryBot.create(:transaction, invoice: invoice_5, result: "success")}
  let!(:transaction_15) {FactoryBot.create(:transaction, invoice: invoice_5, result: "success")}
  let!(:transaction_16) {FactoryBot.create(:transaction, invoice: invoice_5, result: "failed")}

  let!(:invoice_6) {FactoryBot.create(:invoice, created_at: "Sun, 9 Jan 2022 06:10:00 UTC +00:00")}
  let!(:invoice_7) {FactoryBot.create(:invoice, created_at: "Mon, 10 Jan 2022 06:15:00 UTC +00:00")}

  let!(:invoice_item_1) {FactoryBot.create(:invoice_item, invoice: invoice_6, status: "pending")}
  let!(:invoice_item_2) {FactoryBot.create(:invoice_item, invoice: invoice_7, status: "packaged")}
  let!(:invoice_item_3) {FactoryBot.create(:invoice_item, status: "shipped")}
  let!(:invoice_item_4) {FactoryBot.create(:invoice_item, status: "shipped")}

  before(:each) do
    visit '/admin/'
  end

  it 'shows admin header' do
    within("#admin-dashboard-header") do
      expect(page).to have_content("ADMIN DASHBOARD")
    end
  end

  it 'links to merchants index' do
    within("#admin-dashboard-nav") do
      click_link("Merchants")
      expect(current_path).to eq("/admin/merchants")
    end
  end

  it 'links to invoices index' do
    within("#admin-dashboard-nav") do
      click_link("Invoices")
      expect(current_path).to eq("/admin/invoices")
    end
  end

  it 'shows the names of the top 5 customers' do
    expect(customer_2.last_name).to appear_before(customer_4.first_name)
    expect(customer_4.last_name).to appear_before(customer_1.first_name)
    expect(customer_1.last_name).to appear_before(customer_5.first_name)
    expect(customer_5.last_name).to appear_before(customer_3.first_name)
    expect(page).to_not have_content(customer_6.last_name)
  end

  it 'shows number of successful transactions for top 5 customers' do
    within("#top-customer-#{customer_2.last_name}") do
      expect(page).to have_content(5)
    end
    within("#top-customer-#{customer_4.last_name}") do
      expect(page).to have_content(4)
    end
    within("#top-customer-#{customer_1.last_name}") do
      expect(page).to have_content(3)
    end
    within("#top-customer-#{customer_3.last_name}") do
      expect(page).to have_content(1)
    end
  end

  it 'has a section for Incomplete Invoices' do
    expect(page).to have_content("Incomplete Invoices")
  end

  it 'has a list of all invoices with unshipped items' do
    expect(page).to have_content(invoice_item_1.invoice.id)
    expect(page).to have_content(invoice_item_2.invoice.id)
  end

  it 'has invoices which are all links to that invoices admin show page' do
    expect(page).to have_link(invoice_item_1.invoice.id, href: "/admin/invoices/#{invoice_item_1.invoice.id}")
    expect(page).to have_link(invoice_item_2.invoice.id, href: "/admin/invoices/#{invoice_item_2.invoice.id}")
  end

  it 'lists the invoices displays the date they were created' do
    expect(page).to have_content(invoice_item_1.invoice.created_at.strftime("%A, %B %-d, %Y"))
    expect(page).to have_content(invoice_item_2.invoice.created_at.strftime("%A, %B %-d, %Y"))
  end

  it 'lists in order' do
    expect(invoice_item_1.invoice.created_at.strftime("%A, %B %-d, %Y")).to appear_before(invoice_item_2.invoice.created_at.strftime("%A, %B %-d, %Y"))
  end

end
