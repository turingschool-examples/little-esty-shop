require 'rails_helper'

describe 'Admin Invoices show page' do
  describe 'As an admin' do
    describe 'When I visit the admin invoice show page' do
      let!(:customer_2) {create(:customer) }
      let!(:merchant_2) {create(:merchant) }
      let!(:invoice_2) {create(:invoice, customer_id: customer_2.id) }
      let!(:item_2) {create(:item, merchant_id: merchant_2.id) }
      let!(:invoice_item_3) {create(:invoice_item, item_id: item_2.id, quantity: 10, unit_price: 9, invoice_id: invoice_2.id ) }
      let!(:invoice_item_4) {create(:invoice_item, item_id: item_2.id, quantity: 10, unit_price: 9, invoice_id: invoice_2.id ) }
      let!(:transaction_2) {create(:transaction, invoice_id: invoice_2.id, result: 'success') }

      it "I see information related to that invoice including: - Invoice id - Invoice status - Invoice created_at date in the format 'Monday, July 18, 2019' - Customer first and last name" do
        visit admin_invoice_path(invoice_2)
      
        expect(page).to have_content("#{invoice_2.id}")
        expect(page).to have_content("#{invoice_2.status}")
        expect(page).to have_content("#{invoice_2.created_at.strftime("%A, %B %e, %Y")}")
        expect(page).to have_content("#{invoice_2.customer.first_name}")
        expect(page).to have_content("#{invoice_2.customer.last_name}")
      end
    end
  end
end