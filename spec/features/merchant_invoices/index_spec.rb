require 'rails_helper'

RSpec.describe 'merchant invoices index page' do

  before(:each) do
    @merchant = Merchant.create!(name: 'Brylan')
    @item_1 = @merchant.items.create!(name: 'Bottle', unit_price: 10, description: 'H20')
    @item_2 = @merchant.items.create!(name: 'Can', unit_price: 5, description: 'Soda')
    @customer = Customer.create!(first_name: "Billy", last_name: "Jonson")
    @invoice_1 = @customer.invoices.create(status: "in progress")
    @invoice_2 = @customer.invoices.create(status: "in progress")
    @invoice_item_1 = InvoiceItem.create(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 10, unit_price: 10, status: "packaged")
    @invoice_item_2 = InvoiceItem.create(item_id: @item_1.id, invoice_id: @invoice_2.id, quantity: 10, unit_price: 10, status: "packaged")

    @customer_2 = Customer.create!(first_name: "Illy", last_name: "Jonson")
    @invoice_3 = @customer_2.invoices.create(status: "in progress")
    @invoice_4 = @customer_2.invoices.create(status: "in progress")
    @invoice_item_3 = InvoiceItem.create(item_id: @item_2.id, invoice_id: @invoice_3.id, quantity: 10, unit_price: 10, status: "packaged")
    @invoice_item_4 = InvoiceItem.create(item_id: @item_2.id, invoice_id: @invoice_4.id, quantity: 10, unit_price: 10, status: "packaged")

    @merchant_2 = Merchant.create!(name: 'Chris')
    @item_3 = @merchant_2.items.create!(name: 'Ball', unit_price: 5, description: 'Fun')
    @customer_3 = Customer.create!(first_name: "Illy", last_name: "Jonson")
    @invoice_5 = @customer_2.invoices.create(status: "in progress")
    @invoice_item_5 = InvoiceItem.create(item_id: @item_3.id, invoice_id: @invoice_5.id, quantity: 10, unit_price: 10, status: "packaged")

    visit "/merchants/#{@merchant.id}/invoices"
  end

  it "displays all invoices that include at least one of my merchant's items" do
    expect(page).to have_content("Invoice: #{@invoice_1.id}")
    expect(page).to have_content("Invoice: #{@invoice_2.id}")
    expect(page).to have_content("Invoice: #{@invoice_3.id}")
    expect(page).to have_content("Invoice: #{@invoice_4.id}")
    expect(page).to_not have_content("Invoice: #{@invoice_5.id}")
  end

  it "each invoice_id links to the merchant invoice show page" do
    within "#invoice-#{@invoice_1.id}" do
      click_link "#{@invoice_1.id}"
    end
    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}")

    visit "/merchants/#{@merchant.id}/invoices"

    within "#invoice-#{@invoice_2.id}" do
      click_link "#{@invoice_2.id}"
    end
    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice_2.id}")

    visit "/merchants/#{@merchant.id}/invoices"

    within "#invoice-#{@invoice_3.id}" do
      click_link "#{@invoice_3.id}"
    end
    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice_3.id}")

    visit "/merchants/#{@merchant.id}/invoices"

    within "#invoice-#{@invoice_4.id}" do
      click_link "#{@invoice_4.id}"
    end
    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice_4.id}")
  end
end
