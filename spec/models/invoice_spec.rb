require "rails_helper"

RSpec.describe Invoice do
  describe "relationships" do
    it {should have_many :transactions}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe "class methods" do
    # describe "#all_incomplete_invoices" do
    #   it "returns all invoices with a status of 'in progress' in order from old to new" do
    #     customer = Customer.create!(first_name: "Abe", last_name: "Oldman")
    #     invoice2 = customer.invoices.create!(status: 1)
    #     invoice3 = customer.invoices.create!(status: 2)
    #     invoice1 = customer.invoices.create!(status: 0)
    #     invoice4 = customer.invoices.create!(status: 0)

    #     expect(Invoice.all_incomplete_invoices).to eq([invoice2, invoice1, invoice4])
    #   end
    # end

    describe "#find_all_invoices_not_shipped" do
      it "returns all records that do not have a status of 'shipped'" do
        merchant = Merchant.create!(name: "mel")
        customer = Customer.create!(first_name: "Abe", last_name: "Oldman")

        item1 = merchant.items.create!(name: "thing", description: "thingy", unit_price: 10)
        invoice2 = customer.invoices.create!(status: 0)
        invoice1 = customer.invoices.create!(status: 0)
        invoice3 = customer.invoices.create!(status: 0)

        invoice_item1 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 2, unit_price: 5, status: 2)
        invoice_item2 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 2, unit_price: 5, status: 0)
        invoice_item3 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 2, unit_price: 5, status: 1)
        invoice_item4 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 2, unit_price: 5, status: 2)

        invoice_item5 = InvoiceItem.create!(item: item1, invoice: invoice2, quantity: 2, unit_price: 5, status: 2)
        invoice_item6 = InvoiceItem.create!(item: item1, invoice: invoice2, quantity: 2, unit_price: 5, status: 0)
        invoice_item7 = InvoiceItem.create!(item: item1, invoice: invoice2, quantity: 2, unit_price: 5, status: 1)
        invoice_item8 = InvoiceItem.create!(item: item1, invoice: invoice2, quantity: 2, unit_price: 5, status: 2)

        invoice_item9 = InvoiceItem.create!(item: item1, invoice: invoice3, quantity: 2, unit_price: 5, status: 2)
        invoice_item10 = InvoiceItem.create!(item: item1, invoice: invoice3, quantity: 2, unit_price: 5, status: 2)

        expect(Invoice.find_all_invoices_not_shipped).to eq([invoice1, invoice2])
      end
    end
  end

  describe "instance methods" do
    describe "#invoice_items" do
      it " returns info on all items in an invoice" do
        customer = Customer.create!(first_name: "Very", last_name: "Rich")
        merchant = Merchant.create!(name: "CCC")
        item_1 = merchant.items.create!(name: "thing", description: "thingy", unit_price: 10)
        item_2 = merchant.items.create!(name: "stuff", description: "thingy", unit_price: 10)
        item_3 = merchant.items.create!(name: "blarb", description: "thingy", unit_price: 10)
        invoice = customer.invoices.create!(status: 0, created_at: "2012-03-07 12:54:10 UTC")
        invoice_item1 = InvoiceItem.create!(item: item_1, invoice: invoice, quantity: 3, unit_price: 5, status: 0)
        invoice_item2 = InvoiceItem.create!(item: item_2, invoice: invoice, quantity: 3, unit_price: 5, status: 0)

        tested = invoice.invoice_items.map { |item| item.name}

        expect(tested).to eq(["thing", "stuff"])
      end
    end

    describe "#expected_revenue" do
      it " returns the total of all items quanity*unit_price" do
        customer = Customer.create!(first_name: "Very", last_name: "Rich")
        merchant = Merchant.create!(name: "CCC")
        item_1 = merchant.items.create!(name: "thing", description: "thingy", unit_price: 10)
        item_2 = merchant.items.create!(name: "stuff", description: "thingy", unit_price: 10)
        item_3 = merchant.items.create!(name: "blarb", description: "thingy", unit_price: 10)
        invoice = customer.invoices.create!(status: 0, created_at: "2012-03-07 12:54:10 UTC")
        invoice_item1 = InvoiceItem.create!(item: item_1, invoice: invoice, quantity: 3, unit_price: 5, status: 0)
        invoice_item2 = InvoiceItem.create!(item: item_2, invoice: invoice, quantity: 3, unit_price: 5, status: 0)

        expect(invoice.expected_revenue[invoice.id]).to eq(30)
      end
    end
  end

end
