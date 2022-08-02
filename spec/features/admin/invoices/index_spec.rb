require 'rails_helper'

RSpec.describe Invoice do
  describe 'invoice#index' do
    it 'shows all the invoices in the system' do
      merchant = Merchant.create!(name: "Al Capone", created_at: Time.now, updated_at: Time.now)

      customer1 = Customer.create!(first_name: "Babe", last_name: "Ruth", created_at: Time.now, updated_at: Time.now)
      customer2 = Customer.create!(first_name: "Charles", last_name: "Bukowski", created_at: Time.now, updated_at: Time.now)
      customer3 = Customer.create!(first_name: "Josey", last_name: "Wales", created_at: Time.now, updated_at: Time.now)

      invoice1 = Invoice.create!(status: 0, customer_id: customer1.id, created_at: Time.now, updated_at: Time.now)
      invoice2 = Invoice.create!(status: 0, customer_id: customer2.id, created_at: Time.now, updated_at: Time.now)
      invoice3 = Invoice.create!(status: 0, customer_id: customer3.id, created_at: Time.now, updated_at: Time.now)

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
  end
end
