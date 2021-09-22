require 'rails_helper'

RSpec.describe 'Merchant Invoice show page' do
  before(:each) do
    @merchant = Merchant.create!(name: "John Sandman")
    @item_1 = @merchant.items.create!(name: "Shirt", description: "A shirt", unit_price: 4000)
    @item_2 = @merchant.items.create!(name: "Bird shirt", description: "bird shirt", unit_price: 4000)

    @customer_1 = Customer.create!(first_name: "Tony", last_name: "Gonzales")
    @invoice_1 = @customer_1.invoices.create!(status: "Success")
    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, unit_price: 6777, invoice_id: @invoice_1.id, quantity: 1, status: 2 )
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, unit_price: 4577, invoice_id: @invoice_1.id, quantity: 4, status: 2 )

    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"
  end

  it 'shows the invoice information of that merchant' do
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at)
    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.last_name)
  end

  it 'displays all the items on the invoice' do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)

    within("#Invoice-Item-#{@invoice_item_1.id}") do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@invoice_item_1.quantity)
      expect(page).to have_content(@invoice_item_1.unit_price)
      expect(page).to have_content(@invoice_item_1.status)
    end
  end
end
