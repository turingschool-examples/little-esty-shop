require "rails_helper"

RSpec.describe InvoiceItem do
  describe "relationships" do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end
end

  # describe "class methods" do
  #   describe "#find_all_invoices_not_shipped" do
  #     it "returns all records that do not have a status of 'shipped'" do
  #       merchant = Merchant.create!(name: "mel")
  #       customer = Customer.create!(first_name: "Abe", last_name: "Oldman")
  #
  #       item1 = merchant.items.create!(name: "thing", description: "thingy", unit_price: 10)
  #       invoice2 = customer.invoices.create!(status: 0)
  #       invoice1 = customer.invoices.create!(status: 0)
  #       invoice3 = customer.invoices.create!(status: 0)
  #
  #       invoice_item1 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 2, unit_price: 5, status: 2)
  #       invoice_item2 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 2, unit_price: 5, status: 0)
  #       invoice_item3 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 2, unit_price: 5, status: 1)
  #       invoice_item4 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 2, unit_price: 5, status: 2)
  #
  #       invoice_item5 = InvoiceItem.create!(item: item1, invoice: invoice2, quantity: 2, unit_price: 5, status: 2)
  #       invoice_item6 = InvoiceItem.create!(item: item1, invoice: invoice2, quantity: 2, unit_price: 5, status: 0)
  #       invoice_item7 = InvoiceItem.create!(item: item1, invoice: invoice2, quantity: 2, unit_price: 5, status: 1)
  #       invoice_item8 = InvoiceItem.create!(item: item1, invoice: invoice2, quantity: 2, unit_price: 5, status: 2)
  #
  #       invoice_item9 = InvoiceItem.create!(item: item1, invoice: invoice3, quantity: 2, unit_price: 5, status: 2)
  #       invoice_item10 = InvoiceItem.create!(item: item1, invoice: invoice3, quantity: 2, unit_price: 5, status: 2)
  #
  #       expect(InvoiceItem.find_all_invoices_not_shipped()).to eq([invoice1, invoice2])
  #     end
  #   end
  
