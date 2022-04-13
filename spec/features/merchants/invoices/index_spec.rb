require 'rails_helper'

RSpec.describe 'merchant dashboard' do
  before :each do
    @merchant1 = Merchant.create!(name: "Pabu")

    @item1 = Item.create!(name: "Brush", description: "Brushy", unit_price: 10, merchant_id: @merchant1.id)

    @customer1 = Customer.create!(first_name: "Loki", last_name: "R")
    @customer2 = Customer.create!(first_name: "Thor", last_name: "R")

    @invoice1 = @customer1.invoices.create!(status: "completed")
    @invoice2 = @customer2.invoices.create!(status: "completed")

    InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, status: 1, quantity: 20, unit_price: 10)
    InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item1.id, status: 1, quantity: 30, unit_price: 10)

    visit merchant_invoices_path(@merchant1)
  end

  it 'has header' do
    expect(page).to have_content("Invoices index")
  end

  it 'shows all invoices related to merchant' do
    within("#invoices") do
      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice2.id)
    end
  end

  it 'has link to each invoice show page' do
    within("#invoices") do
      click_link @invoice1.id
      expect(current_path).to eq(merchant_invoice_path(@merchant1, @invoice1))
    end
  end
  it 'has link to seperate invoice' do
    within("#invoices") do
      click_link @invoice2.id
      expect(current_path).to eq(merchant_invoice_path(@merchant1, @invoice2))
    end
  end
end
