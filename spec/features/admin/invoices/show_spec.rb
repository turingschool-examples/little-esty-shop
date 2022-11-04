require "rails_helper"
require "date"

RSpec.describe "Admin Invoice show page" do 
  describe "As an admin, when I visit admin/invoices/:id" do 
    it "shows information related to that invoice including, id, status, created_at date, and Customer first and last name" do 
      customer = Customer.create!(first_name: "Gandalf", last_name: "Thegrey")
      feb_third = DateTime.new(2022,2,3,4,5,6)
      march_third = DateTime.new(2022,3,3,6,2,3)
  
      invoice_1 = customer.invoices.create!(status: 0, created_at: feb_third)
      invoice_2 = customer.invoices.create!(status: 1, created_at: march_third)

      visit admin_invoice_path(invoice_1)

      expect(page).to have_content("Invoice ##{invoice_1.id}")
      expect(page).to have_content("Status: Cancelled")
      expect(page).to have_content("Created on: Thursday, February 03, 2022")
      expect(page).to have_content("Customer:")
      expect(page).to have_content("Gandalf Thegrey")
    end
  end
end