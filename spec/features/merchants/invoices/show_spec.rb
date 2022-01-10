require 'rails_helper'

RSpec.describe 'merchant items show page' do
  
  let!(:merchant_1) {FactoryBot.create(:merchant)}
  let!(:merchant_2) {FactoryBot.create(:merchant)}

  let!(:item_1) {FactoryBot.create(:item, merchant: merchant_1)}
  let!(:item_2) {FactoryBot.create(:item, merchant: merchant_1)}
  let!(:item_3) {FactoryBot.create(:item, merchant: merchant_1)}
  let!(:item_4) {FactoryBot.create(:item, merchant: merchant_2)}

  let!(:invoice_item_1) {FactoryBot.create(:invoice_item, quantity: 100, unit_price: 200, item: item_1)}
  let!(:invoice_item_2) {FactoryBot.create(:invoice_item, item: item_2)}
  let!(:invoice_item_3) {FactoryBot.create(:invoice_item, item: item_3)}
  let!(:invoice_item_4) {FactoryBot.create(:invoice_item, item: item_4)}

  it 'displays invoice attributes' do 
    visit "merchants/#{merchant_1.id}/invoices/#{invoice_item_1.invoice.id}"
    
    expect(page).to have_content(invoice_item_1.invoice.id)
    expect(page).to have_content(invoice_item_1.invoice.status)
    expect(page).to have_content(invoice_item_1.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content("Customer Name: #{invoice_item_1.invoice.customer.first_name} #{invoice_item_1.invoice.customer.last_name}")

    expect(page).to_not have_content(invoice_item_2.invoice.id)
    expect(page).to_not have_content(invoice_item_2.invoice.customer.first_name)
    expect(page).to_not have_content(invoice_item_2.invoice.customer.last_name)
  end

  it 'displays all items associated with an invoice' do 
    visit "merchants/#{merchant_1.id}/invoices/#{invoice_item_1.invoice.id}"

    expect(page).to have_content(invoice_item_1.invoice.items.first.name)
  end

  it 'displays the quantity of the item purchased on an invoice' do 
    visit "merchants/#{merchant_1.id}/invoices/#{invoice_item_1.invoice.id}"
    
    expect(page).to have_content(invoice_item_1.quantity)
  end

  it 'displays the unit price of the item purchased on an invoice' do 
    visit "merchants/#{merchant_1.id}/invoices/#{invoice_item_1.invoice.id}"
    
    expect(page).to have_content(invoice_item_1.unit_price)
  end

  it 'displays the unit price of the item purchased on an invoice' do 
    visit "merchants/#{merchant_1.id}/invoices/#{invoice_item_1.invoice.id}"
    
    expect(page).to have_content(invoice_item_1.status)
  end
end