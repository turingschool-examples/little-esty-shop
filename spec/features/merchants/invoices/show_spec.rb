require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page', type: :feature do

  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson')}
  let!(:merchant_2) {Merchant.create!(name: 'Deb Millhouse')}

  let!(:item_1) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 150)}
  let!(:item_2) {merchant_1.items.create!(name: "Bracelet", description: "A thing around your wrist", unit_price: 300)}
  let!(:item_3) {merchant_1.items.create!(name: "Earrings", description: "A thing around your ears", unit_price: 220)}
  let!(:item_4) {merchant_2.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 150)}
  let!(:item_5) {merchant_2.items.create!(name: "Bracelet", description: "A thing around your wrist", unit_price: 300)}
  let!(:item_6) {merchant_2.items.create!(name: "Earrings", description: "A thing around your ears", unit_price: 220)}

  let!(:customer_1) {Customer.create!(first_name: "Billy", last_name: "Joel")}
  let!(:customer_2) {Customer.create!(first_name: "Britney", last_name: "Spears")}
  let!(:customer_3) {Customer.create!(first_name: "Prince", last_name: "Mononym")}

  let!(:invoice_1)  {customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')}
  let!(:invoice_2)  {customer_1.invoices.create!(status: 1, created_at: '2012-03-28 12:54:09')}
  let!(:invoice_3)  {customer_2.invoices.create!(status: 1, created_at: '2012-04-25 08:54:09')}
  let!(:invoice_4)  {customer_3.invoices.create!(status: 1, created_at: '2012-03-29 07:54:09')}

  let!(:invoice_item_1) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: 0)}
  let!(:invoice_item_2) {InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_1.id, status: 0)}
  let!(:invoice_item_3) {InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_1.id, status: 0)}
  let!(:invoice_item_4) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, status: 0)}
  let!(:invoice_item_5) {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: 0)}
  let!(:invoice_item_6) {InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: 0)}
  let!(:invoice_item_7) {InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, status: 0)}
  let!(:invoice_item_8) {InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_4.id, status: 0)}

  let!(:transaction_1) {invoice_1.transactions.create!(result: 'success')}
  let!(:transaction_2) {invoice_2.transactions.create!(result: 'success')}
  let!(:transaction_3) {invoice_3.transactions.create!(result: 'success')}
  let!(:transaction_4) {invoice_4.transactions.create!(result: 'success')}

  before (:each) do
    visit merchant_invoice_path(merchant_1.id, invoice_1.id)
  end

  describe 'Merchant sees invoice attributes on page' do
    it 'displays invoice id' do
      expect(page).to have_content(invoice_1.id)
    end

    it 'displays invoice status' do
      expect(page).to have_content(invoice_1.status)
    end

    it 'displays invoice created_at date in format DAY, MM DD,YYYY' do
      expect(page).to have_content("Sunday, March 25, 2012")
    end

    it 'displays customer first and last name' do
      expect(page).to have_content("First Name: #{customer_1.first_name}")
      expect(page).to have_content("Last Name: #{customer_1.last_name}")
    end
  end
end
