require 'rails_helper'

RSpec.describe "merchant dashboard", type: :feature do
  it 'shows the merchants name' do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones", created_at: Time.now, updated_at: Time.now)

    visit "/merchants/#{merchant_1.id}/dashboard"

    within('#merchant-details') do
      expect(page).to have_content('Schroeder-Jerde')
      expect(page).to_not have_content('Klein, Rempel and Jones')
    end
  end

  it "has links to merchant items index and merchant invoices index" do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones", created_at: Time.now, updated_at: Time.now)

    visit "/merchants/#{merchant_1.id}/dashboard"
    expect(page).to have_link("Items", href: "/merchants/#{merchant_1.id}/items")
    expect(page).to have_link("Invoices", href: "/merchants/#{merchant_1.id}/invoices")
    expect(page).to_not have_link("Items", href: "/merchants/#{merchant_2.id}/items")
    expect(page).to_not have_link("Invoices", href: "/merchants/#{merchant_2.id}/invoices")
  end

  it 'lists top 5 customers and number of successful transactions for each customer' do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id)
    item_2 = Item.create!create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id)
    item_3 = Item.create!items.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id)
    customer_1 = Customer.create!(first_name: "James", last_name: "Franco")
    customer_2 = Customer.create!(first_name: "Frank", last_name: "Jameson")
    customer_3 = Customer.create!(first_name: "John", last_name: "Smith")
    customer_4 = Customer.create!(first_name: "Zack", last_name: "Adams")
    customer_5 = Customer.create!(first_name: "Chloe", last_name: "Wheeler")
    customer_6 = Customer.create!(first_name: "Zoe", last_name: "Atkins")
    invoices_1 = customer_1.invoices.create!(status: 1)
    invoices_2 = customer_2.invoices.create!(status: 1)
    invoices_3 = customer_3.invoices.create!(status: 1)
    invoices_4 = customer_4.invoices.create!(status: 1)
    invoices_5 = customer_5.invoices.create!(status: 1)
    invoices_6 = customer_6.invoices.create!(status: 1)
  end
end
