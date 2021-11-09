require 'rails_helper'

RSpec.describe 'Admin invoice show page' do
  describe 'page layout' do
    before(:each) do
      @customer = Customer.create!(first_name: 'John', last_name: 'Wick')
      @invoice = Invoice.create!(customer_id: @customer.id, status: 0)

      visit "/admin/invoices/#{@invoice.id}"
    end

    it 'shows the invoice header' do
      expect(page).to have_content("Invoice #{@invoice.id}")
    end
  end
end
