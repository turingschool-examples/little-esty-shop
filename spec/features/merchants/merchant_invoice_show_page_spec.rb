require 'rails_helper'

RSpec.describe "Merchant Invoice Show Page" do
  before :each do
    @merchant = Merchant.create(name: "John's Jewelry")
    @item1 = @merchant.items.create(name: "Gold Ring", description: "14K Wedding Band",
                                  unit_price: 599.95)
    @item2 = @merchant.items.create(name: "Pearl Necklace", description: "Beautiful White Pearls",
                                  unit_price: 250.00)
    @customer = Customer.create!(first_name: "Bob", last_name: "Jones")
    @invoice1 = @customer.invoices.create(status: 0)
    @invoice2 = @customer.invoices.create(status: 1)
    @invoice_item1 = InvoiceItem.create!(invoice_id: @invoice1.id,
                                       item_id: @item1.id, quantity: 500,
                                       unit_price: 599.95, status: 0)
    @invoice_item2 = InvoiceItem.create!(invoice_id: @invoice1.id,
                                       item_id: @item2.id, quantity: 2,
                                       unit_price: 250.00, status: 0)
    @invoice_item3 = InvoiceItem.create!(invoice_id: @invoice2.id,
                                       item_id: @item2.id, quantity: 1000,
                                       unit_price: 200.00, status: 1)
  end
  describe "When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)" do
    it "I see the invoice attributes listed" do
      visit "/merchant/#{@merchant.id}/invoices/#{@invoice2.id}"
        within "#invoice-info" do
          expect(page).to have_content(invoice.id)
          expect(page).to have_content(invoice.status)
          expect(page).to have_content(invoice.created_at)
        end
    end
  end
end




#
#
# Merchant Invoice Show Page
#
# As a merchant
# When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)
# Then I see information related to that invoice including:
# - Invoice id
# - Invoice status
# - Invoice created_at date in the format "Monday, July 18, 2019"