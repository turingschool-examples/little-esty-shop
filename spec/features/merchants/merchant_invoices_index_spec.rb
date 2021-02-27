require "rails_helper"

RSpec.describe "Merchant Invoices Index Page" do
  describe "When I visit my merchant's invoices index (/merchants/merchant_id/invoices)" do
    it "Then I see all of the invoices that include at least one of my merchant's items" do
      merchant = Merchant.create(name: "John's Jewelry")
      item1 = merchant.items.create(name: "Gold Ring", description: "14K Wedding Band",
                                    unit_price: 599.95)
      item2 = merchant.items.create(name: "Pearl Necklace", description: "Beautiful White Pearls",
                                    unit_price: 250.00)
      customer = Customer.create!(first_name: "Bob", last_name: "Jones")
      invoice1 = customer.invoices.create(status: 0)
      invoice2 = customer.invoices.create(status: 1)
      invoice_item1 = InvoiceItem.create!(invoice_id: invoice1.id,
                                         item_id: item1.id, quantity: 500,
                                         unit_price: 599.95, status: 0)
      invoice_item2 = InvoiceItem.create!(invoice_id: invoice1.id,
                                         item_id: item2.id, quantity: 2,
                                         unit_price: 250.00, status: 0)
      invoice_item3 = InvoiceItem.create!(invoice_id: invoice2.id,
                                         item_id: item2.id, quantity: 1000,
                                         unit_price: 200.00, status: 1)
      visit "/merchant/#{merchant.id}/invoices"

      expect(page).to have_content("My Invoices")

      within("#merchant-invoices") do
        expect(page).to have_content(invoice1.id)
        expect(page).to have_content(invoice2.id)
        expect(page).to have_link("#{invoice1.id}")
        expect(page).to have_link("#{invoice2.id}")
        save_and_open_page
      end
    end
  end
end
