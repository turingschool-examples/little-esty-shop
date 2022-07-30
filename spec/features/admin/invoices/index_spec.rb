require 'rails_helper'

RSpec.describe 'Admins Invoice Index page' do
  describe 'when i visit the admin invoice index' do
    it 'shows all invoices in the system' do
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")

      invoice_1 = Invoice.create!(status: 1, customer_id: customer_1.id)
      invoice_2 = Invoice.create!(status: 2, customer_id: customer_1.id)
      invoice_3 = Invoice.create!(status: 0, customer_id: customer_1.id)

      visit invoices_path

      within "#inv-#{invoice_1.id}" do
        expect(page).to have_content(invoice_1.id)
        expect(page).to_not have_content(invoice_2.id)
        expect(page).to_not have_content(invoice_3.id)
      end

      within "#inv-#{invoice_2.id}" do
        expect(page).to have_content(invoice_2.id)
        expect(page).to_not have_content(invoice_1.id)
        expect(page).to_not have_content(invoice_3.id)
      end

      within "#inv-#{invoice_3.id}" do
        expect(page).to have_content(invoice_3.id)
        expect(page).to_not have_content(invoice_2.id)
        expect(page).to_not have_content(invoice_1.id)
      end
    end
  end
end


# Admin Invoices Index Page::: As an admin, When I visit the admin Invoices index ("/admin/invoices") 
# Then I see a list of all Invoice ids in the system
# Each id links to the admin invoice show page