require 'rails_helper'

RSpec.describe 'as an admin', type: :feature do
  describe 'when I visit and admin invoices show page' do
    before(:each) do
      @merchant = Merchant.create!(name: 'House of thingys')
      @customer = Customer.create!(first_name: 'Hooman', last_name:"Mcbuythings")
      @invoice_1 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 0, created_at: 2012-03-25)
      @invoice_2 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 0)
      @invoice_3 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 1)
    end

    it 'then i see invoice id, status and created at date formated as "Monday, July 18, 2019"' do
      visit admin_invoice_path("#{@invoice_1.id}")

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content("Friday, January 08, 2021")
    end
  end
end