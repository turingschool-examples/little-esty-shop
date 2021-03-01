require 'rails_helper'

RSpec.describe "Merchant invoice show page" do
  before :each do
    @customer = Customer.create!(first_name: "First1", last_name: "Last1")
    @invoice = @customer.invoices.create!(status: 1)
    @merchant = Merchant.create!(name: "Merchant1")
    @item1 = @merchant.items.create!(name: "Item1", description: "Description1", unit_price: 2)
    @item2 = @merchant.items.create!(name: "Item2", description: "Description2", unit_price: 3)

    @invoice_item1 = InvoiceItem.create!(item: @item1, invoice: @invoice, quantity: 1, unit_price: 1, status: 0)
    @invoice_item2 = InvoiceItem.create!(item: @item2, invoice: @invoice, quantity: 2, unit_price: 2, status: 1)
  end

  describe "when I visit a merchant invoice show page" do
    it "shows the invoice information" do
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

      expect(page).to have_content("Invoice ID: #{@invoice.id}")
      expect(page).to have_content("Invoice status: #{@invoice.status}")
      expect(page).to have_content("Created at: #{@invoice.created_at.strftime('%A, %b %d, %Y')}")
    end
  end
end
