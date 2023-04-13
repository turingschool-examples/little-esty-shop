require 'rails_helper'

RSpec.describe 'Admin Invoices Index Page', type: :feature do
  before (:each) do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_2.id)
  end
  #User Story 33
  describe "Admin Invoice Show Page" do
    it "displays all information related to that invoice" do
      visit admin_invoice_path(@invoice_1)
      within("##{@invoice_1.id}_id") do
        expect(page).to have_content("Invoice ID: #{@invoice_1.id}")
        expect(page).to have_content("Invoice Status: #{@invoice_1.status}")
        expect(page).to have_content("Invoice Created At: #{@invoice_1.convert_created_at}")
        expect(page).to have_content("Customer Name: #{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")

        expect(page).to_not have_content("#{@invoice_2.id}")
        expect(page).to_not have_content("#{@invoice_2.customer.first_name}")
        expect(page).to_not have_content("#{@invoice_2.customer.last_name}")
      end

      visit admin_invoice_path(@invoice_2)
      within("##{@invoice_2.id}_id") do
        expect(page).to have_content("Invoice ID: #{@invoice_2.id}")
        expect(page).to have_content("Invoice Status: #{@invoice_2.status}")
        expect(page).to have_content("Invoice Created At: #{@invoice_2.convert_created_at}")
        expect(page).to have_content("Customer Name: #{@invoice_2.customer.first_name} #{@invoice_2.customer.last_name}")

        expect(page).to_not have_content("#{@invoice_1.id}")
        expect(page).to_not have_content("#{@invoice_1.customer.first_name}")
        expect(page).to_not have_content("#{@invoice_1.customer.last_name}")
      end
    end
  end

end