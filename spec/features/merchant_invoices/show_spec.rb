require 'rails_helper'

RSpec.describe 'merchant invoice show page' do

  before(:each) do
    @merchant = Merchant.create!(name: 'Brylan')
    @item_1 = @merchant.items.create!(name: 'Bottle', unit_price: 10, description: 'H20')
    @item_2 = @merchant.items.create!(name: 'Can', unit_price: 5, description: 'Soda')
    @customer = Customer.create!(first_name: "Billy", last_name: "Jonson")
    @invoice_1 = @customer.invoices.create(status: "in progress", created_at: Time.parse("2022-04-12 09:54:09"))

  end
  
  it "displays information related to the invoice" do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content("in progress")
    expect(page).to have_content("Tuesday, April 12, 2022")
    expect(page).to have_content("Billy")
    expect(page).to have_content("Jonson")
  end
end
