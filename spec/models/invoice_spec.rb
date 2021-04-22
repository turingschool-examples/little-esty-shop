require "rails_helper"

RSpec.describe Invoice do
  describe "relationships" do
    it {should have_many :transactions}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe "class methods" do
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


        tested = invoice.invoice_items.map { |item| item.item_id}

        expect(tested).to eq([item_1.id, item_2.id])
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

        expect(invoice.expected_revenue(merchant.id)[invoice.id]).to eq(30)
      end
    end
  end

  describe 'instance methods' do
    describe 'item_sell_info' do
      it 'returns all items associated with invoice, as well as selling info' do
        customer = Customer.create!(first_name: "A", last_name: "AA")
        merchant = Merchant.create!(name: "merchant")
        invoice1 = customer.invoices.create!(status: 'in progress')
        item1 = merchant.items.create!(name: "thing", description: "thingy", unit_price: 1)
        item2 = merchant.items.create!(name: "stuff", description: "stuffy", unit_price: 2)
        item3 = merchant.items.create!(name: "it", description: "itty", unit_price: 3)
        item4 = merchant.items.create!(name: "fake", description: "fakey", unit_price: 4)
        invoice_item1 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity:10, unit_price: 11, status: 0)
        invoice_item2 = InvoiceItem.create!(item: item2, invoice: invoice1, quantity:20, unit_price: 22, status: 1)
        invoice_item2 = InvoiceItem.create!(item: item3, invoice: invoice1, quantity:30, unit_price: 33, status: 2)

        actual = invoice1.item_sell_info
        actual_name = actual.map do |invoice_item|
          invoice_item.item.name
        end
        actual_quantity = actual.map do |invoice_item|
          invoice_item.quantity
        end
        actual_price = actual.map do |invoice_item|
          invoice_item.unit_price
        end
        actual_status = actual.map do |invoice_item|
          invoice_item.status
        end

        expect(actual_name).to eq(['thing', 'stuff', 'it'])
        expect(actual_quantity).to eq([10, 20, 30])
        expect(actual_price).to eq([11, 22, 33])
        expect(actual_status).to eq(['packaged', 'pending', 'shipped'])
      end
    end

    it 'returns the total revenue for an invoice' do
      customer = Customer.create!(first_name: "A", last_name: "AA")
      merchant = Merchant.create!(name: "merchant")
      invoice1 = customer.invoices.create!(status: 'in progress')
      item1 = merchant.items.create!(name: "thing", description: "thingy", unit_price: 1)
      item2 = merchant.items.create!(name: "stuff", description: "stuffy", unit_price: 2)
      item3 = merchant.items.create!(name: "it", description: "itty", unit_price: 3)
      item4 = merchant.items.create!(name: "fake", description: "fakey", unit_price: 4)
      invoice_item1 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity:1, unit_price: 1, status: 0) #1
      invoice_item2 = InvoiceItem.create!(item: item2, invoice: invoice1, quantity:2, unit_price: 2, status: 1) #4
      invoice_item3 = InvoiceItem.create!(item: item3, invoice: invoice1, quantity:5, unit_price: 10, status: 2) #50

      expect(invoice1.revenue).to eq(55)
    end
  end
end
