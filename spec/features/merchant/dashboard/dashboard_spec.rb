require 'rails_helper'

RSpec.describe 'The Merchant Dashboard' do
  before :each do
    @katz = Merchant.create!(name: 'Katz Kreations')
    @mrpickles = Customer.create!(first_name: 'Mr', last_name: 'Pickles')
    @sashimi = Customer.create!(first_name: 'Sashimi', last_name: 'Kity')
    @invoice1 = Invoice.create!(status: 0, customer_id: @mrpickles.id)
    @invoice2 = Invoice.create!(status: 0, customer_id: @mrpickles.id)
    @item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: @katz.id)
    @item2 = Item.create!(name: 'toy', description: 'fun', unit_price: '5000', merchant_id: @katz.id)
    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100, status: 1)
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100, status: 2)
  end

  it "displays the merchant's name" do
    visit "/merchants/#{@katz.id}/dashboard"
    expect(page).to have_content(@katz.name)
  end

  it "has links to merchant items and invoices" do
    visit "/merchants/#{@katz.id}/dashboard"
    click_on "#{@katz.name}'s items"
    expect(current_path).to eq("/merchants/#{@katz.id}/items")
    visit "/merchants/#{@katz.id}/dashboard"
    click_on "#{@katz.name}'s invoices"
    expect(current_path).to eq("/merchants/#{@katz.id}/invoices")
  end

  it "has a section ready to ship with names of items that are oredered but not shipped" do
    visit "/merchants/#{@katz.id}/dashboard"
    within '#ready_to_ship' do
      expect(page).to have_content(@item1.name)
      expect(page).to_not have_content(@item2.name)
    end
  end

  it "ready to ship has the item ids of the invoices that ordered the items" do
    visit "/merchants/#{@katz.id}/dashboard"
    within '#ready_to_ship' do
      expect(page).to have_content(@invoice1.id)
      expect(page).to_not have_content(@invoice2.id)
    end
  end

  it "in ready to ship the item ids are links to merchant_invoices" do
    visit "/merchants/#{@katz.id}/dashboard"
    within '#ready_to_ship' do
      click_on "Invoice ID: #{@invoice_item1.id}"
      expect(current_path).to eq("/merchants/#{@katz.id}/invoices")
    end
  end

  it "in ready to ship the invoice dates are present" do
    visit "/merchants/#{@katz.id}/dashboard"
    within '#ready_to_ship' do
      expect(page).to have_content(@invoice1.created_at)
    end
  end

  it "in ready to ship the invoices apear from least to most recent" do
    visit "/merchants/#{@katz.id}/dashboard"
    within '#ready_to_ship' do
      expect(@invoice1.id).to appear_before(@invoice2.id)
    end
  end
end
