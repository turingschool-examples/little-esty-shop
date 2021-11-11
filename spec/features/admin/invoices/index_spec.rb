require 'rails_helper'

RSpec.describe 'admin invoices index' do
  describe 'page layout' do
    before(:each) do
      @customer = Customer.create!(first_name: 'John', last_name: 'Wick')
      @invoice = Invoice.create!(customer_id: @customer.id, status: 0)

      visit "/admin/invoices"
    end

    it 'has a header' do
      expect(page).to have_content('Admin Invoices')
    end

    it 'shows the id of invoices' do
      expect(page).to have_content(@invoice.id)
    end

    it 'links to the invoice show page' do
      click_on "#{@invoice.id}"

      expect(page).to have_current_path("/admin/invoices/#{@invoice.id}")
    end
  end
end
