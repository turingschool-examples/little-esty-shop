require 'rails_helper'
require 'date'

RSpec.describe Item, type: :model do
  describe "Relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "instance methods" do 
    describe "#top_selling_date" do 
      it "returns the DateTime object of the created_at for the invoice with the most sales of that item" do 
        merchant = Merchant.create!(name: "The Candle Shop")
        item = merchant.items.create!(name: "Pine Scented Candle", description: "beeswax candle", unit_price: 4)
        customer = Customer.create!(first_name: "Lee", last_name: "Saville")

        jan_first = DateTime.new(2022,1,1,4,5,6)
        jan_second = DateTime.new(2022,1,2,4,5,6)
        feb_first = DateTime.new(2022,2,1,4,5,6)
        feb_second = DateTime.new(2022,2,2,4,5,6)

        invoice_1 = customer.invoices.create!(status: 1, created_at: jan_first)
        invoice_2 = customer.invoices.create!(status: 1, created_at: jan_second)
        invoice_3 = customer.invoices.create!(status: 1, created_at: feb_first)
        invoice_4 = customer.invoices.create!(status: 1, created_at: feb_second)

        InvoiceItem.create!(invoice: invoice_1, item: item, quantity: 6, unit_price: 4)
        InvoiceItem.create!(invoice: invoice_2, item: item, quantity: 4, unit_price: 4)
        InvoiceItem.create!(invoice: invoice_3, item: item, quantity: 12, unit_price: 4)
        InvoiceItem.create!(invoice: invoice_4, item: item, quantity: 12, unit_price: 4)

        expect(item.top_selling_date).to eq(feb_first)
      end
    end
  end
end