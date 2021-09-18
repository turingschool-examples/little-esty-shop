require 'rails_helper'

RSpec.describe 'Merchant Invoice show page' do
  before(:each) do
    @merchant = Merchant.create!(name: "John Sandman")
    @item_1 = @merchant.items.create!(name: "Shirt", description: "A shirt", unit_price: 40)
    @customer_1 = Customer.create!(first_name: "Tony", last_name: "Gonzales")
    @invoice_1 = @customer_1.invoices.create!(status: "Success")
    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, status: "Success" )
  end

  it 'shows the invoice information of that merchant' do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at)
    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.last_name)
  end
end
