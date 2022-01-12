require 'rails_helper'

RSpec.describe 'Merchant Invoices Index Page', type: :feature do

  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson')}
  let!(:merchant_2) {Merchant.create!(name: 'Deb Millhouse')}

  let!(:item_1) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 150)}
  let!(:item_2) {merchant_1.items.create!(name: "Bracelet", description: "A thing around your wrist", unit_price: 300)}
  let!(:item_3) {merchant_1.items.create!(name: "Earrings", description: "A thing around your ears", unit_price: 220)}
  let!(:item_4) {merchant_2.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 150)}
  let!(:item_5) {merchant_2.items.create!(name: "Bracelet", description: "A thing around your wrist", unit_price: 300)}

  let!(:customer_1) {Customer.create!(first_name: "Billy", last_name: "Joel")}
  let!(:customer_2) {Customer.create!(first_name: "Britney", last_name: "Spears")}
  let!(:customer_3) {Customer.create!(first_name: "Prince", last_name: "Mononym")}

  let!(:invoice_1)  {customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')}
  let!(:invoice_2)  {customer_1.invoices.create!(status: 1, created_at: '2012-03-28 12:54:09')}
  let!(:invoice_3)  {customer_2.invoices.create!(status: 1, created_at: '2012-04-25 08:54:09')}
  let!(:invoice_4)  {customer_3.invoices.create!(status: 1, created_at: '2012-03-29 07:54:09')}

  let!(:invoice_item_1) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, unit_price: item_1.unit_price, quantity: 2, status: 0)}
  let!(:invoice_item_2) {InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_1.id, unit_price: item_4.unit_price, quantity: 2, status: 0)}
  let!(:invoice_item_3) {InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_1.id, unit_price: item_5.unit_price, quantity: 2, status: 0)}
  let!(:invoice_item_4) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, unit_price: item_1.unit_price, quantity: 2, status: 0)}
  let!(:invoice_item_5) {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, unit_price: item_2.unit_price, quantity: 2, status: 0)}
  let!(:invoice_item_6) {InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, unit_price: item_3.unit_price, quantity: 2, status: 0)}

  before (:each) do
    visit merchant_invoices_path(merchant_1)
  end

  scenario 'mechant sees all invoices that have at least one of their items' do
    expect(page).to have_content(invoice_1.id)
    expect(page).to have_content(invoice_2.id)
    expect(page).to have_content(invoice_3.id)
    expect(page).to have_no_content(invoice_4.id)
  end

  scenario 'visitor sees each invoice id number links to the merchant invoice show page' do
    expect(page).to have_link("#{invoice_1.id}", href: merchant_invoice_path(merchant_1.id, invoice_1.id))
    expect(page).to have_link("#{invoice_2.id}", href: merchant_invoice_path(merchant_1.id, invoice_2.id))
    expect(page).to have_link("#{invoice_3.id}", href: merchant_invoice_path(merchant_1.id, invoice_3.id))
  end
end
