require 'rails_helper'

RSpec.describe 'merchant dashboard' do
  it "When I visit a merchant dashboard I see the name of my merchant" do
    merchant = create(:merchant, name: 'Bob')
    visit "/merchants/#{merchant.id}/dashboard"
    expect(page).to have_content('Bob')
  end

  it 'has a link to merchant invoices index' do
    merchant = create(:merchant_with_invoices, invoice_count: 3)
    visit "/merchants/#{merchant.id}/dashboard"
    click_link "Invoices"
    expect(current_path).to eq("/merchants/#{merchant.id}/invoices")
  end

  it 'has a link to merchant items index' do
    merchant = create(:merchant_with_items, item_count: 3)
    visit "/merchants/#{merchant.id}/dashboard"
    click_link "Items"
    expect(current_path).to eq("/merchants/#{merchant.id}/items")
  end

  it "has the names of the top 5 customers with largest number of completed transactions" do
    merchant = create(:merchant)

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

    #update all items to be under original merchant
    Item.where(merchant_id: [merchant_1.id, merchant_2.id, merchant_3.id, merchant_4.id, merchant_5.id]).update(merchant: merchant)
    
    visit "/merchants/#{merchant.id}/dashboard"

    within 'div.top_customers' do
      expect('Abe').to appear_before('Bob')
      expect('Bob').to appear_before('Charlie')
      expect('Charlie').to appear_before('John')
      expect('John').to appear_before('Zach')
    end
  end
end
