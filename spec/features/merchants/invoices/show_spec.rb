require 'rails_helper'

RSpec.describe 'Shows 1 invoice, and all its attributes', type: :feature do
  before do
    @merchant1 = Merchant.create!(name: "The Tornado")
    @item1 = @merchant1.items.create!(name: "SmartPants", description: "IQ + 20", unit_price: 125)
    @item2 = @merchant1.items.create!(name: "SmartPants", description: "IQ + 20", unit_price: 125)
    @customer1 = Customer.create!(first_name: "Marky", last_name: "Mark" )
    @invoice1 = @customer1.invoices.create!(status: 0)
    @invoice_item1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 2, unit_price: 125, status: 1)
    @invoice_item1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item2.id, quantity: 2, unit_price: 125, status: 1)
  end

  it "links from the merchants/invoices index to merch/inv/show" do
    visit "/merchants/#{@merchant1.id}/invoices"

    click_link("Invoice Number: #{@invoice1.id}")

    expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
  end

  it "lists all the attributes for a single invoice." do
    visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

    expect(page).to have_content("#{@invoice1.id}")
    expect(page).to have_content("Customer name: #{@invoice1.customer.first_name} #{@invoice1.customer.last_name}")
    expect(page).to have_content("Customer ID: #{@invoice1.customer.id}")
    expect(page).to have_content("Invoice status: #{@invoice1.status}")
    expect(page).to have_content("#{@invoice1.created_at.strftime("%A, %B %d, %Y")}")
  end

  it 'lists information for each item on invoice' do
    visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

    expect(page).to have_content("Item name: #{@item1.name}")
    expect(page).to have_content("Item price: #{@item1.unit_price}")
    expect(page).to have_content("Quantity purchased: #{@invoice1.item_quantity(@item1)}")
  end

  it 'does not display items from other merchants' do
    other_merchant = create(:merchant)
    other_item = create(:item, merchant: other_merchant)

    visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

    expect(page).not_to have_content(other_item.name)
  end
end
