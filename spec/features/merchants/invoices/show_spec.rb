require 'rails_helper'

RSpec.describe 'merchant items show page' do
  let!(:merchant_1) {FactoryBot.create(:merchant)}
  let!(:merchant_2) {FactoryBot.create(:merchant)}

  let!(:item_1) {FactoryBot.create(:item, merchant: merchant_1)}
  let!(:item_2) {FactoryBot.create(:item, merchant: merchant_1)}
  let!(:item_3) {FactoryBot.create(:item, merchant: merchant_1)}
  let!(:item_4) {FactoryBot.create(:item, merchant: merchant_2)}

  let!(:invoice_1) {FactoryBot.create(:invoice, status: 0)}

  let!(:transaction_1) {FactoryBot.create(:transaction, invoice: invoice_1, credit_card_expiration_date: Date.today, result: 0)}

  let!(:invoice_item_1) {FactoryBot.create(:invoice_item, quantity: 100, unit_price: 100, item: item_1, invoice: invoice_1, status: 0)}
  let!(:invoice_item_2) {FactoryBot.create(:invoice_item, quantity: 50, unit_price: 50, item: item_2, invoice: invoice_1, status: 1)}
  let!(:invoice_item_3) {FactoryBot.create(:invoice_item, item: item_3)}
  let!(:invoice_item_4) {FactoryBot.create(:invoice_item, item: item_4)}

  it 'displays invoice attributes' do 
    visit "merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

    expect(page).to have_content(invoice_1.id)
    expect(page).to have_content(invoice_1.status)
    expect(page).to have_content(invoice_1.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content(invoice_1.customer.first_name)
    expect(page).to have_content(invoice_1.customer.last_name)
  end

  it 'displays all items associated with an invoice' do 
    visit "merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

    expect(page).to have_content(invoice_item_1.invoice.items.first.name)
    expect(page).to have_content(invoice_item_2.invoice.items.first.name)
    
    expect(page).to_not have_content(invoice_item_3.invoice.items.first.name)
  end

  it 'displays the quantity of the item purchased on an invoice' do 
    visit "merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"
    
    expect(page).to have_content(invoice_item_1.quantity)
    expect(page).to have_content(invoice_item_2.quantity)

    expect(page).to_not have_content(invoice_item_3.quantity)
  end

  it 'displays the unit price of the item purchased on an invoice' do 
    visit "merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"
    
    expect(page).to have_content(invoice_item_1.unit_price)
    expect(page).to have_content(invoice_item_2.unit_price)

    expect(page).to_not have_content(invoice_item_3.unit_price)
  end

  it 'displays the unit price of the item purchased on an invoice' do 
    visit "merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"
    
    expect(page).to have_content(invoice_item_1.status)
    expect(page).to have_content(invoice_item_2.status)
  end

  it 'displays the total revenue for an invoice' do 
    visit "merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"
    
    expect(page).to have_content("Total Revenue: #{invoice_1.total_revenue}")
  end
end