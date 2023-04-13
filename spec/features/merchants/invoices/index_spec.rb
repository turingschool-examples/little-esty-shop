require 'rails_helper'

RSpec.describe "Merchant Invoices Index Page" do
  describe "display" do
    before do
      test_data
    end
    it "displays all invoices for the given merchant" do
      visit merchant_invoices_path(@merchant_2)

      expect(page).to have_content("#{@merchant_2.name}'s Invoices")
      expect(page).to have_content("Invoice ##{@invoice_1.id}")
      expect(page).to have_content("Invoice ##{@invoice_2.id}")
      expect(page).to have_content("Invoice ##{@invoice_3.id}")
      expect(page).to have_content("Invoice ##{@invoice_4.id}")
      expect(page).to have_content("Invoice ##{@invoice_5.id}")
      expect(page).to have_content("Invoice ##{@invoice_6.id}")
      expect(page).to have_link(@invoice_1.id, href: merchant_invoice_path(@merchant_2.id, @invoice_1.id))
      expect(page).to have_link(@invoice_2.id, href: merchant_invoice_path(@merchant_2, @invoice_2))
      expect(page).to have_link(@invoice_3.id, href: merchant_invoice_path(@merchant_2, @invoice_3))
      expect(page).to have_link(@invoice_4.id, href: merchant_invoice_path(@merchant_2, @invoice_4))
      expect(page).to have_link(@invoice_5.id, href: merchant_invoice_path(@merchant_2, @invoice_5))
      expect(page).to have_link(@invoice_6.id, href: merchant_invoice_path(@merchant_2, @invoice_6))
      expect(page).to_not have_content(@invoice_7.id)
      expect(page).to_not have_content(@invoice_8.id)
      expect(page).to_not have_content(@invoice_9.id)
      expect(page).to_not have_content(@invoice_10.id)
    end

    it "merchant_3" do
      visit merchant_invoices_path(@merchant_3)
      
      click_link @invoice_7.id

      expect(current_path).to eq(merchant_invoice_path(@merchant_3, @invoice_7))
    end
  end
end