require "rails_helper"

RSpec.describe "The Admin Invoices Index page" do 
  # When I visit the admin Invoices index ("/admin/invoices")
  # Then I see a list of all Invoice ids in the system
  # Each id links to the admin invoice show page
  describe "As an admin, when I visit /admin/invoices" do 
    it "displays a list of all Invoice ids in the system, each id links to the admin invoice show page" do 
      customer = Customer.create!(first_name: "Gandalf", last_name: "Thegrey")
      invoice_1 = customer.invoices.create!(status: 0)
      invoice_2 = customer.invoices.create!(status: 1)
      invoice_3 = customer.invoices.create!(status: 2)

      visit admin_invoices_path

      within "#invoice-#{invoice_1.id}" do 
        expect(page).to have_link("Invoice ##{invoice_1.id}", href: admin_invoice_path(invoice_1))
      end
      within "#invoice-#{invoice_2.id}" do 
        expect(page).to have_link("Invoice ##{invoice_2.id}", href: admin_invoice_path(invoice_2))
      end
      within "#invoice-#{invoice_3.id}" do 
        expect(page).to have_link("Invoice ##{invoice_3.id}", href: admin_invoice_path(invoice_3))
      end
    end
  end
end