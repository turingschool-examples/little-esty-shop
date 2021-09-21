require 'rails_helper'

RSpec.describe 'merchant invoice index page' do
  before(:each) do
    @merchant = Merchant.create!(name: "John Sandman")
    @item = @merchant.items.create!(name: "Shirt", description: "A shirt", unit_price: 40)
    @customer = Customer.create!(first_name: "Sammy", last_name: "Sosa")
    @invoice_1 = @item.invoices.create!(status: "Success", customer_id: @customer.id)
    @invoice_2 = @item.invoices.create!(status: "Pending", customer_id: @customer.id)
  end

  it 'shows each invoice that include the merchants items' do
    visit merchant_invoices_path(@merchant)

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_2.id)
  end

  it 'has a link as each invoice id to its show page' do
    visit merchant_invoices_path(@merchant)
    click_on(@invoice_1.id)
    
    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}")
  end
end
