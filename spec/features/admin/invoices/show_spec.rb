require 'rails_helper'

RSpec.describe 'Admin Invoices Show page' do
  describe 'invoice show reveals info related to invoice' do
    it 'shows an invoices specific info' do
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")

      invoice_1 = Invoice.create!(status: 1, customer_id: customer_1.id)

      visit "/admin/invoices/#{invoice_1.id}"

      created_at = invoice_1.created_at.strftime("%A, %B %e, %Y")

      expect(page).to have_content(invoice_1.id)
      expect(page).to have_content("Status: cancelled")
      expect(page).to have_content("Created at: #{created_at}")
      expect(page).to have_content("David Smith")
    end
  end
end