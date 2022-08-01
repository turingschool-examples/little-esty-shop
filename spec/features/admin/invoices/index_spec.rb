require 'rails_helper'

RSpec.describe Invoice do
  describe 'invoice#index' do
    it 'shows all the invoices in the system' do
      merchant = Merchant.create!(name: "Al Capone")

      customer1 = Customer.create!(first_name: "Babe", last_name: "Ruth")
      customer2 = Customer.create!(first_name: "Charles", last_name: "Bukowski")
      customer3 = Customer.create!(first_name: "Josey", last_name: "Wales")

      invoice1 = Invoice.create!(status: 0, customer_id: customer1.id)
      invoice2 = Invoice.create!(status: 0, customer_id: customer2.id)
      invoice3 = Invoice.create!(status: 0, customer_id: customer3.id)

      visit admin_invoices_path

      within(".customer_invoice-#{invoice1.id}") do
        expect(page).to have_link(invoice1.id)
      end

      within(".customer_invoice-#{invoice2.id}") do
        expect(page).to have_link(invoice2.id)
      end

      within(".customer_invoice-#{invoice3.id}") do
        expect(page).to have_link(invoice3.id)
      end
    end

    it 'each invoice is a link to an invoice show page'
  end
end