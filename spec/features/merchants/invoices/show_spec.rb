require "rails_helper"

RSpec.describe "Merchant Invoices show" do
  describe "Displays" do
    it "invoices that have merchant's items" do
      merchant1 = create(:merchant)
      items = create_list(:item, 5, merchant: merchant1, unit_price: 1)

      invoice = create(:invoice, merchant: merchant1)
      items.each do |item|
        create(:invoice_item, item: item, invoice: invoice, quantity: 5, unit_price: 1)
      end
      # create(:transaction, invoice: invoice, result: 0)

      visit merchant_invoice_path(merchant1, invoice)
  
      expect(page).to have_content(invoice.id)
      expect(page).to have_content(invoice.created_at.strftime("%A, %B %-d, %Y"))
      expect(page).to have_content(invoice.status)
    end
    it "customer info" do
      merchant1 = create(:merchant)
      items = create_list(:item, 5, merchant: merchant1, unit_price: 1)

      customer = create(:customer, first_name: "Linda", last_name: "Mayhew")

      invoice = create(:invoice, merchant: merchant1, customer: customer)

      items.each do |item|
        create(:invoice_item, item: item, invoice: invoice, quantity: 5, unit_price: 1)
      end
      # create(:transaction, invoice: invoice, result: 0)

      visit merchant_invoice_path(merchant1, invoice)

      expect(page).to have_content("Linda Mayhew")
      expect(page).to have_content(customer.address)
    end
  end
end