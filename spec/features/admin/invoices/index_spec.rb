require 'rails_helper'

RSpec.describe "As an admin" do
  describe 'when I visit the admin invoices index' do
    it 'can show the name of each invoice in the system' do
      customer1 = Customer.create(first_name: "Bob", last_name: "Bobette")
      invoice1 = Invoice.create(customer_id: customer1.id, status: 0)
      invoice2 = Invoice.create(customer_id: customer1.id, status: 2)
      invoice3 = Invoice.create(customer_id: customer1.id, status: 1)

      visit '/admin/invoices'

      expect(page).to have_content(invoice1.id)
      expect(page).to have_content(invoice2.id)
      expect(page).to have_link("Link to this invoice")
      save_and_open_page
    end
  end
end
