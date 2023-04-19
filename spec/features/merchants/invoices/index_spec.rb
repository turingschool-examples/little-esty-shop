require 'rails_helper'

RSpec.describe "Merchant Invoices Index Page" do
  before (:each) do
    stub_request(:get, "https://api.unsplash.com/photos/random?client_id=FlgsxiCZm-o34965PDOwh6xVsDINZFbzSwcz0__LKZQ&query=merchant")
      .to_return(status: 200, body: File.read('./spec/fixtures/merchant.json'))
    stub_request(:get, "https://api.unsplash.com/photos/5Fxuo7x-eyg?client_id=aOXB56mTdUD88zHCvISJODxwbTPyRRsOk0rA8Ha-cbc")
      .to_return(status: 200, body: File.read('./spec/fixtures/app_logo.json'))
  end
  describe "display" do
    before do
      test_data
    end
    it "displays all invoices for the given merchant" do
      visit merchant_invoices_path(@merchant_2)

      expect(page).to have_content("#{@merchant_2.name}'s Invoices")
      expect(page).to have_content("Invoice ##{@invoice_7.id}")
      expect(page).to have_content("Invoice ##{@invoice_8.id}")
      expect(page).to have_content("Invoice ##{@invoice_9.id}")
      expect(page).to have_content("Invoice ##{@invoice_10.id}")
      expect(page).to have_content("Invoice ##{@invoice_11.id}")

      expect(page).to have_link("#{@invoice_7.id}", href: merchant_invoice_path(@merchant_2, @invoice_7))
      expect(page).to have_link("#{@invoice_8.id}", href: merchant_invoice_path(@merchant_2, @invoice_8))
      expect(page).to have_link("#{@invoice_9.id}", href: merchant_invoice_path(@merchant_2, @invoice_9))
      expect(page).to have_link("#{@invoice_10.id}", href: merchant_invoice_path(@merchant_2, @invoice_10))
      expect(page).to have_link("#{@invoice_11.id}", href: merchant_invoice_path(@merchant_2, @invoice_11))
    
      expect(page).to_not have_content(@invoice_1.id)
      expect(page).to_not have_content(@invoice_2.id)
      expect(page).to_not have_content(@invoice_3.id)
      expect(page).to_not have_content(@invoice_4.id)
    end

    it "merchant_3" do
      visit merchant_invoices_path(@merchant_3)
      
      click_link "#{@invoice_7.id}"

      expect(current_path).to eq(merchant_invoice_path(@merchant_3, @invoice_7))
    end
  end
end