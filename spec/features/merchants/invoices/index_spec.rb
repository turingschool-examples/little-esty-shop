require "rails_helper"

RSpec.describe "Merchant Invoices index" do
  describe "Displays" do
    it "invoices that have merchant's items" do
      merchant1 = create(:merchant)
      items = create_list(:item, 5, merchant: merchant1, unit_price: 1)

      5.times do |index|
        invoice = create(:invoice, merchant: merchant1, created_at: Date.today - index)
        items[index..-1].each do |item|
          create(:invoice_item, item: item, invoice: invoice, quantity: 5, unit_price: 1)
        end
        # create(:transaction, invoice: invoice, result: 0)
      end

      visit merchant_invoices_path(merchant1)

      expect(page).to have_css("#invoice-5")

      Invoice.all.each do |i|
        expect(page).to have_link(i.id, href: merchant_invoice_path(merchant1, i))
      end
    end
  end
end