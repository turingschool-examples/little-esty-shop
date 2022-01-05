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
    merchant = create(:merchant_with_completed_invoices, invoice_count: 20)
    customer_1 = create(:customer, first_name: 'Bob')
    customer_2 = create(:customer, first_name: 'John')
    customer_3 = create(:customer, first_name: 'Abe')
    customer_4 = create(:customer, first_name: 'Zach')
    customer_5 = create(:customer, first_name: 'Charlie')

    # Assign completed transactions to specific customers.
    first = merchant.invoices.first.id
    last = merchant.invoices.last.id
    merchant.invoices.where(id: first..first + 5).update(customer_id: customer_1.id)
    merchant.invoices.where(id: first + 6..first + 7).update(customer_id: customer_2.id)
    merchant.invoices.where(id: first + 8..first + 15).update(customer_id: customer_3.id)
    merchant.invoices.where(id: first + 16).update(customer_id: customer_4.id)
    merchant.invoices.where(id: first + 17..last).update(customer_id: customer_5.id)

    # I thought this would work but it didn't
    # merchant.invoices.first(6).update(customer_id: customer_1.id)
    # merchant.invoices.limit(2).offset(6).update(customer_id: customer_2.id)
    # merchant.invoices.limit(8).offset(8).update(customer_id: customer_3.id)
    # merchant.invoices.limit(1).offset(16).update(customer_id: customer_4.id)
    # merchant.invoices.last(3).update(customer_id: customer_5.id)

    visit "/merchants/#{merchant.id}/dashboard"

    within 'div.top_customers' do
      expect('Abe').to appear_before('Bob')
      expect('Bob').to appear_before('Charlie')
      expect('Charlie').to appear_before('John')
      expect('John').to appear_before('Zach')
    end
  end
end
