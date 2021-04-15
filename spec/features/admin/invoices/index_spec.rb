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
<<<<<<< HEAD
      # save_and_open_page
=======
>>>>>>> 1ed24213cde376d6bf5bdd4113f00c3595f87885
    end
  end
end
