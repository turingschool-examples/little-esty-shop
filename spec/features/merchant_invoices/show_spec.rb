require 'rails_helper'

RSpec.describe 'merchant invoice show page' do

  before(:each) do
    @merchant = Merchant.create!(name: 'Brylan')
    @item_1 = @merchant.items.create!(name: 'Bottle', unit_price: 10, description: 'H20')
    @item_2 = @merchant.items.create!(name: 'Can', unit_price: 5, description: 'Soda')
    @customer = Customer.create!(first_name: "Billy", last_name: "Jonson")
    @invoice_1 = @customer.invoices.create(status: "in progress", created_at: Time.parse("2022-04-12 09:54:09"))

  end

#   As a merchant
# When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)
# Then I see information related to that invoice including:
#
# Invoice id
# Invoice status
# Invoice created_at date in the format "Monday, July 18, 2019"
# Customer first and last name
  it "displays information related to the invoice" do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content("in progress")
    expect(page).to have_content("Tuesday, April 12, 2022")
    expect(page).to have_content("Billy")
    expect(page).to have_content("Jonson")
  end
end
