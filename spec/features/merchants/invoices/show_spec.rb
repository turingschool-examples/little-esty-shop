require 'rails_helper'

RSpec.describe 'merchant items show page' do
  let!(:merchant_1) {FactoryBot.create(:merchant)}
  let!(:merchant_2) {FactoryBot.create(:merchant)}

  let!(:item_1) {FactoryBot.create(:item, id: 123456789, merchant: merchant_1, unit_price: 100)}
  let!(:item_2) {FactoryBot.create(:item, merchant: merchant_1, unit_price: 50)}
  let!(:item_3) {FactoryBot.create(:item, merchant: merchant_1, unit_price: 300)}
  let!(:item_4) {FactoryBot.create(:item, merchant: merchant_2, unit_price: 400)}

  let!(:invoice_1) {FactoryBot.create(:invoice, status: 0)}
  let!(:invoice_2) {FactoryBot.create(:invoice, status: 1)}

  let!(:transaction_1) {FactoryBot.create(:transaction, invoice: invoice_1, credit_card_expiration_date: Date.today, result: 0)}

  let!(:invoice_item_1) {FactoryBot.create(:invoice_item, quantity: 100, unit_price: 100, item: item_1, invoice: invoice_1, status: 0)}
  let!(:invoice_item_2) {FactoryBot.create(:invoice_item, quantity: 50, unit_price: 50, item: item_2, invoice: invoice_1, status: 1)}
  let!(:invoice_item_3) {FactoryBot.create(:invoice_item, quantity: 300, unit_price: 300, item: item_3, invoice: invoice_2, status: 2)}
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
  end

  it 'displays the quantity of the item purchased on an invoice' do 
    visit "merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"
    
    expect(page).to have_content(invoice_item_1.quantity)
    expect(page).to have_content(invoice_item_2.quantity)
  end

  it 'displays the unit price of the item purchased on an invoice' do 
    visit "merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"
    
    expect(page).to have_content(invoice_item_1.unit_price)
    expect(page).to have_content(invoice_item_2.unit_price)
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

  it 'can update invoice status' do
    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

    within "#item_id#{item_1.id}" do 
      expect(page).to have_select(:change_status, selected: "#{invoice_item_1.status}")
      select 'shipped', from: :change_status
      click_on "Update Invoice Status"
    end 

    expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}")
    
    within "#item_id#{item_1.id}" do 
      expect(page).to have_select(:change_status, selected: 'shipped')
    end 
  end
end