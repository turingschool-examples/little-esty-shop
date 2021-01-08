require 'rails_helper'

RSpec.describe 'As an admin', type: :feature do
  describe 'when I visit admin invoices index' do
    before(:each) do
      @merchant = Merchant.create!(name: 'House of thingys')
      @customer = Customer.create!(first_name: 'Hooman', last_name:"Mcbuythings")
      @invoice_1 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 0)
      @invoice_2 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 0)
      @invoice_3 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 1)
    end

    it 'I see a list of all invoice Ids in the system' do
      visit admin_invoices_path

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_2.id)
      expect(page).to have_content(@invoice_3.id)
    end

    it 'each ID links to the admin invoice show page' do
      visit admin_invoices_path

      click_on @invoice_1.id

      expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
    end
  end
end