require 'rails_helper'

RSpec.describe "Merchant Invoice Show Page" do
  before :each do
    @merchant = Merchant.create(name: "John's Jewelry")
    @not_merchant = Merchant.create(name: "Mikey Mouse Rings")
    @not_item = @not_merchant.items.create(name: "Mouse Ring", description: "Oh Toodles", unit_price: 12.99)
    @item1 = @merchant.items.create(name: "Gold Ring", description: "14K Wedding Band",
                                  unit_price: 599.95)
    @item2 = @merchant.items.create(name: "Pearl Necklace", description: "Beautiful White Pearls",
                                  unit_price: 250.00)
    @customer = Customer.create!(first_name: "Bob", last_name: "Jones")
    @not_customer = Customer.create!(first_name: "Mike", last_name: "Jones")
    @invoice1 = @customer.invoices.create(status: 0)
    @invoice2 = @customer.invoices.create(status: 1)
    @invoice_item1 = InvoiceItem.create!(invoice_id: @invoice1.id,
                                       item_id: @item1.id, quantity: 500,
                                       unit_price: 599.95, status: 0)
    @invoice_item2 = InvoiceItem.create!(invoice_id: @invoice1.id,
                                       item_id: @item2.id, quantity: 2,
                                       unit_price: 250.00, status: 0)
    @not_invoice_item = InvoiceItem.create!(invoice_id: @invoice2.id,
                                       item_id: @not_item.id, quantity: 976,
                                       unit_price: 10.00, status: 1)
  end
  describe "When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)" do
    it "I see the invoice attributes listed" do
      visit "/merchant/#{@merchant.id}/invoices/#{@invoice1.id}"
        within "#invoice-info" do
          expect(page).to have_content(@invoice1.id)
          expect(page).to have_content(@invoice1.status_format)
          expect(page).to have_content(@invoice1.date_format)
        end
    end
    it "I see all of the customer information related to that invoice " do
      visit "/merchant/#{@merchant.id}/invoices/#{@invoice1.id}"
        within "#invoice-customer-info" do
          expect(page).to have_content(@customer.name)
          expect(page).to_not have_content(@not_customer.name)
        end
    end
    it "Then I see all of my items on the invoice(item name, quantity, price sold, invoice item status)" do
      visit "/merchant/#{@merchant.id}/invoices/#{@invoice1.id}"
        expect(page).to_not have_content(@not_item.name)
        expect(page).to_not have_content(@not_invoice_item.quantity)
        expect(page).to_not have_content(@not_invoice_item.unit_price)
        expect(page).to_not have_content(@not_invoice_item.status)

        within "#invoice-items-#{@invoice_item1.id}-info" do
          expect(page).to have_content(@item1.name)
          expect(page).to have_content(@invoice_item1.quantity)
          expect(page).to have_content(@invoice_item1.unit_price)
          expect(page).to have_content(@invoice_item1.status)
        end
        within "#invoice-items-#{@invoice_item2.id}-info" do
          expect(page).to have_content(@item2.name)
          expect(page).to have_content(@invoice_item2.quantity)
          expect(page).to have_content(@invoice_item2.unit_price)
          expect(page).to have_content(@invoice_item2.status)
        end
    end
  end
end