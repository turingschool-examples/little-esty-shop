require 'rails_helper'

RSpec.describe 'Admin Invoices Index' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Larry's Lucky Ladles")
    @merchant_2 = Merchant.create!(name: "Bob's Burgers")

    @item_1 = Item.create!(name: "Star Wars Ladle", description: "May the soup be with you", unit_price: 10, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Sparkle Ladle", description: "Serve in style", unit_price: 12, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: "Burger Bun Bookends", description: "Books between buns", unit_price: 40, merchant_id: @merchant_2.id)
    @item_4 = Item.create!(name: "Burger Bun Slippers", description: "Buns for your feet", unit_price: 30, merchant_id: @merchant_2.id)

    @customer_1 = Customer.create!(first_name: "Sally", last_name: "Brown")
    @customer_2 = Customer.create!(first_name: "Morgan", last_name: "Freeman")

    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 0, customer_id: @customer_1.id)
    @invoice_3 = Invoice.create!(status: 0, customer_id: @customer_2.id)
    @invoice_4 = Invoice.create!(status: 2, customer_id: @customer_2.id)
  end

  it 'displays a list of all invoices' do
    visit '/admin/invoices'

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_2.id)
    expect(page).to have_content(@invoice_3.id)
    expect(page).to have_content(@invoice_4.id)
  end

  it 'links to each invoices show page' do
    visit '/admin/invoices'

    expect(page).to have_link(@invoice_1.id)
    expect(page).to have_link(@invoice_2.id)
    expect(page).to have_link(@invoice_3.id)
    expect(page).to have_link(@invoice_4.id)
  end
end
