require 'rails_helper'

RSpec.describe 'merchant invoice index page' do
  before(:each) do
    @merchant = Merchant.create!(name: "John Sandman")
    @item = @merchant.items.create!(name: "Shirt", description: "A shirt", unit_price: 40)
    @customer = Customer.create!(first_name: "Sammy", last_name: "Sosa")
    @invoice_1 = @customer.invoices.create!(status: "success")
    @invoice_2 = @customer.invoices.create!(status: "cancelled")
    @invoice_item_1 = @invoice_1.invoice_items.create!(item_id: @item.id, status: 0)
    @invoice_item_2 = @invoice_2.invoice_items.create!(item_id: @item.id, status: 0)

    visit merchant_invoices_path(@merchant)
  end

  it 'shows each invoice that include the merchants' do
    within("#all-invoices") do
      expect(page).to have_content(@invoice_1.id.to_s)
      expect(page).to have_content(@invoice_2.id.to_s)
    end
  end

  it 'has a link as each invoice id to its show page' do
    click_on("#{@invoice_1.id}")
    
    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}")
  end
end
