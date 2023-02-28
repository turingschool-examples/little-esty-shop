require 'rails_helper'

describe 'Admin Invoices index page' do
  describe 'As an admin' do
    describe 'When I visit the admin invoices index ("/admin/invoices")' do
      let!(:customer_2) {create(:customer) }
      let!(:merchant_2) {create(:merchant) }
      let!(:invoice_2) {create(:invoice, customer_id: customer_2.id) }
      let!(:item_2) {create(:item, merchant_id: merchant_2.id) }
      let!(:invoice_item_3) {create(:invoice_item, item_id: item_2.id, quantity: 10, unit_price: 9, invoice_id: invoice_2.id ) }
      let!(:invoice_item_4) {create(:invoice_item, item_id: item_2.id, quantity: 10, unit_price: 9, invoice_id: invoice_2.id ) }
      let!(:transaction_2) {create(:transaction, invoice_id: invoice_2.id, result: 'success') }

      let!(:customer_3) {create(:customer) }
      let!(:merchant_3) {create(:merchant) }
      let!(:invoice_3) {create(:invoice, customer_id: customer_3.id) }
      let!(:item_3) {create(:item, merchant_id: merchant_3.id) }
      let!(:invoice_item_4) {create(:invoice_item, item_id: item_3.id, quantity: 10, unit_price: 8, invoice_id: invoice_3.id ) }
      let!(:invoice_item_5) {create(:invoice_item, item_id: item_3.id, quantity: 10, unit_price: 8, invoice_id: invoice_3.id ) }
      let!(:transaction_3) {create(:transaction, invoice_id: invoice_3.id, result: 'success') }

      let!(:customer_4) {create(:customer) }
      let!(:merchant_4) {create(:merchant) }
      let!(:invoice_4) {create(:invoice, customer_id: customer_4.id) }
      let!(:item_4) {create(:item, merchant_id: merchant_4.id) }
      let!(:invoice_item_5) {create(:invoice_item, item_id: item_4.id, quantity: 10, unit_price: 7, invoice_id: invoice_4.id ) }
      let!(:invoice_item_6) {create(:invoice_item, item_id: item_4.id, quantity: 10, unit_price: 7, invoice_id: invoice_4.id ) }
      let!(:transaction_4) {create(:transaction, invoice_id: invoice_4.id, result: 'success') }

      it "I see a list of all invoice ids in the system and each ID linkes to the admin invoice show page" do
        visit admin_invoices_path
 
        expect(page).to have_link("#{invoice_2.id}")
        expect(page).to have_link("#{invoice_3.id}")
        expect(page).to have_link("#{invoice_4.id}")

        click_link("#{invoice_2.id}")

        expect(current_path).to eq(admin_invoice_path(invoice_2))
      end
    end
  end
end