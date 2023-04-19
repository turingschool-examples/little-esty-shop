require 'rails_helper'

RSpec.describe 'Admin Invoices Index Page', type: :feature do
  before (:each) do
    @customer_1 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_1.id)
    @invoice_3 = create(:invoice, customer_id: @customer_1.id)
  end

  describe "Admin Invoices Index Page (User Story 32)" do
    it "displays all Invoice ids in system" do
      visit admin_invoices_path
      expect(page).to have_content("All Invoices:")
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_2.id)
      expect(page).to have_content(@invoice_3.id)
    end

    it "Each id links to admin invoice show page" do
      visit admin_invoices_path
      expect(page).to have_link("#{@invoice_1.id}")
      click_link("#{@invoice_1.id}")
      expect(current_path).to eq(admin_invoice_path(@invoice_1))

      visit admin_invoices_path
      expect(page).to have_link("#{@invoice_2.id}")
      click_link("#{@invoice_2.id}")
      expect(current_path).to eq(admin_invoice_path(@invoice_2))

      visit admin_invoices_path
      expect(page).to have_link("#{@invoice_3.id}")
      click_link("#{@invoice_3.id}")
      expect(current_path).to eq(admin_invoice_path(@invoice_3))
    end
  end
end