require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
   it { should validate_presence_of :name }

  end

  describe 'instance method' do
    it "#merchants_invoices" do

      merchant1 = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
      merchant2 = Merchant.create!(name: "Billy West", created_at: Time.now, updated_at: Time.now)

      item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item2 = Item.create!(name: "Watch", description: "wearable", unit_price: 400, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item3 = Item.create!(name: "Clock", description: "household", unit_price: 300, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )

      customer1 = Customer.create!(first_name: "Susan", last_name: "Sarandon", created_at: Time.now, updated_at: Time.now)

      invoice1 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer1.id)
      invoice2 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer1.id)

      invoiceitem1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, created_at: Time.now, updated_at: Time.now, quantity: 2, unit_price: 2, status: 1)
      invoiceitem2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, created_at: Time.now, updated_at: Time.now, quantity: 2, unit_price: 2, status: 1)
      invoiceitem3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice2.id, created_at: Time.now, updated_at: Time.now, quantity: 1, unit_price: 2, status: 1)

      expect(merchant1.merchant_invoices).to eq([invoice1])
      expect(merchant2.merchant_invoices).to eq([invoice2])
    end
  end


  describe 'relationships' do
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe '.ready_to_ship' do
    it 'returns all items with invoice status pending or packaged' do
      merchant = Merchant.create!(name: "Al Capone", created_at: Time.now, updated_at: Time.now)

      item_1 = Item.create!(name: "Moonshine", description: "alcohol", unit_price: 2, created_at: Time.now, updated_at: Time.now, merchant_id: merchant.id)

      customer_1 = Customer.create!(first_name: "Babe", last_name: "Ruth", created_at: Time.now, updated_at: Time.now)
      customer_2 = Customer.create!(first_name: "Charles", last_name: "Bukowski", created_at: Time.now, updated_at: Time.now)
      customer_3 = Customer.create!(first_name: "Josey", last_name: "Wales", created_at: Time.now, updated_at: Time.now)
      customer_4 = Customer.create!(first_name: "Popcorn", last_name: "Sutton", created_at: Time.now, updated_at: Time.now)
      customer_5 = Customer.create!(first_name: "Nucky", last_name: "Johnson", created_at: Time.now, updated_at: Time.now)
      customer_6 = Customer.create!(first_name: "Freddy", last_name: "McCoy", created_at: Time.now, updated_at: Time.now)
      customer_7 = Customer.create!(first_name: "Ted", last_name: "Williams", created_at: Time.now, updated_at: Time.now)

      invoice_1 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer_1.id)
      invoice_2 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer_2.id)
      invoice_3 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer_3.id)
      invoice_4 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer_4.id)
      invoice_5 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer_5.id)
      invoice_6 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer_6.id)

      invoice_item_1 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 0, created_at: Time.now, updated_at: Time.now, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 1, created_at: Time.now, updated_at: Time.now, item_id: item_1.id, invoice_id: invoice_2.id)
      invoice_item_3 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 2, created_at: Time.now, updated_at: Time.now, item_id: item_1.id, invoice_id: invoice_3.id)
      invoice_item_4 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 2, created_at: Time.now, updated_at: Time.now, item_id: item_1.id, invoice_id: invoice_4.id)
      invoice_item_5 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 2, created_at: Time.now, updated_at: Time.now, item_id: item_1.id, invoice_id: invoice_5.id)
      invoice_item_6 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 1, created_at: Time.now, updated_at: Time.now, item_id: item_1.id, invoice_id: invoice_6.id)

      expect(merchant.ready_to_ship).to eq([invoice_item_1, invoice_item_2, invoice_item_6])

    end
  end
end
