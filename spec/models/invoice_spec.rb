require 'rails_helper'

RSpec.describe Invoice do
  describe 'validations' do
    it {should validate_presence_of :status}
  end

  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :transactions}
  end

  describe 'instance methods' do
    it 'returns the date in words-ish' do
      customer_1 = Customer.create(id: 1, first_name: 'Bob', last_name: 'Johnson')
      invoice_1 = Invoice.create(id: 1, customer_id: customer_1.id, status: 'cancelled', created_at: "2012-03-25 09:54:09 UTC")

      expect(invoice_1.formatted_date).to eq("Sunday, March 25, 2012")
    end

    it 'returns invoice customer full name' do
      customer_1 = Customer.create(id: 1, first_name: 'Bob', last_name: 'Johnson')
      invoice_1 = Invoice.create(id: 1, customer_id: customer_1.id, status: 'cancelled')

      expect(invoice_1.customer_full_name).to eq("Bob Johnson")
    end

    it 'returns the total revenue from a invoice' do
      merchant_1 = Merchant.create!(name: "Cool Shirts")
      customer_1 = Customer.create(id: 1, first_name: 'Bob', last_name: 'Johnson')
      invoice_1 = Invoice.create(id: 1, customer_id: customer_1.id, status: 'cancelled')
      item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: "Old shirt", description: "moderately ugly shirt", unit_price: 1200, merchant_id: merchant_1.id)
      invoice_item1 = InvoiceItem.create!(item: item_1, invoice: invoice_1, quantity: 5, unit_price: 1200, status: "packaged")
      invoice_item2 = InvoiceItem.create!(item: item_2, invoice: invoice_1, quantity: 5, unit_price: 1000, status: "packaged")
      expect(invoice_1.total_revenue).to eq(11000)
    end
  end
end
