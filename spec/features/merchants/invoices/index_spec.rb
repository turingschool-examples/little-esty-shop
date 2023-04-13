require 'rails_helper'

RSpec.describe "Merchant Invoices Index Page" do
  describe "display" do
    before do
      test_data
    end
    it "displays all invoices for the given merchant" do
      visit merchant_invoices_path(@merchant_1)

      expect(page).to have_content("#{@merchant_1.name}'s Invoices")
      expect(page).to have_content("Invoice ##{@invoice_1.id}")
      expect(page).to have_content(@invoice_2.id)
      expect(page).to have_content(@invoice_3.id)

      expect(page).to have_no_content(@invoice_4.id)
      expect(page).to have_no_content(@invoice_5.id)
      expect(page).to have_no_content(@invoice_6.id)
      expect(page).to have_no_content(@invoice_7.id)
      expect(page).to have_no_content(@invoice_8.id)
      expect(page).to have_no_content(@invoice_9.id)
      expect(page).to have_no_content(@invoice_10.id)
    end
  end
end