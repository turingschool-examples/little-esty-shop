require 'rails_helper'

RSpec.describe 'Show page', type: :feature do
  before do
    @merchant_1 = Merchant.create!(name: 'Hair Care')

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant_1.id)

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1)
    visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
  end

  describe 'invoice show page' do
    xit 'shows invoice information' do

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content("Created at: Monday, November 8, 2021")
    end

    it 'shows invoice customer deatials' do

      expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
    end
  end
end

# As a merchant
# When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)
# Then I see information related to that invoice including:

# Invoice id
# Invoice status
# Invoice created_at date in the format "Monday, July 18, 2019"
# Customer first and last name
