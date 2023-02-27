require "rails_helper"

RSpec.describe "Admin Invoice Show Page" do
  describe "User Story 33" do 
    it 'When I visit an admin invoice show page, then I see information related to that invoice including: id, status, created at and customer name' do
      customer = create(:customer, first_name: "Adam", last_name: "Bailey")

      invoice = create(:invoice, customer: customer, status: 0, created_at: Date.new(2023,1,1))

      visit admin_invoice_path(invoice)

      expect(page).to have_content("Invoice ##{invoice.id}")
      expect(page).to have_content("Status: in progress")
      expect(page).to have_content("Created on: Sunday, January 1, 2023")
      expect(page).to have_content("Adam Bailey")
    end
  end
end