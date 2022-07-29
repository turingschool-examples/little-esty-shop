require 'rails_helper'

RSpec.describe Item do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe '#methods' do
    it 'returns the quantity of an item ordered from invoice item' do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 500, merchant_id: merchant_1.id )
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)
      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)

      expect(item_1.quantity_ordered(invoice_1)).to eq(4)
    end

    it 'returns the unit_price of an item ordered from invoice item' do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 500, merchant_id: merchant_1.id )
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)
      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)

      expect(item_1.price_sold(invoice_1)).to eq(800)
    end

    it 'returns the status of an item ordered from invoice item' do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 500, merchant_id: merchant_1.id )
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)
      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)

      expect(item_1.item_status(invoice_1)).to eq("pending")
    end

    it 'returns the date with the most sales for that item' do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")

      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 500, merchant_id: merchant_1.id )
      
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      customer_2 = Customer.create!(first_name: "Harold", last_name: "Johnson")
      
      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)

      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)

      expect(item_1.top_day).to eq("[]")
    end
  end
end