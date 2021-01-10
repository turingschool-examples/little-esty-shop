require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :items}
    it {should have_many :invoices}
    it {should have_many(:customers).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:invoice_items).through(:items)}
  end

  describe 'instance methods' do
    it "a merchant can identify its top 5 customer names" do
      sally    = Customer.create!(first_name: 'Sally', last_name: 'Smith')
      joel     = Customer.create!(first_name: 'Joel', last_name: 'Hansen')
      john     = Customer.create!(first_name: 'John', last_name: 'Hansen')
      travolta = Customer.create!(first_name: 'Travolta', last_name: 'Hansen')
      sal      = Customer.create!(first_name: 'Sal', last_name: 'Hansen')
      tim      = Customer.create!(first_name: 'Tim', last_name: 'Hansen')
      amazon   = Merchant.create!(name: 'Amazon')
      alibaba  = Merchant.create!(name: 'Alibaba')
      invoice1 = Invoice.create!(status: 1, customer_id: sally.id, merchant_id: amazon.id)
      invoice2 = Invoice.create!(status: 1, customer_id: sally.id, merchant_id: amazon.id)
      invoice3 = Invoice.create!(status: 1, customer_id: joel.id, merchant_id: amazon.id)
      invoice4 = Invoice.create!(status: 1, customer_id: joel.id, merchant_id: amazon.id)
      invoice5 = Invoice.create!(status: 1, customer_id: john.id, merchant_id: amazon.id)
      invoice6 = Invoice.create!(status: 1, customer_id: john.id, merchant_id: amazon.id)
      invoice7 = Invoice.create!(status: 1, customer_id: travolta.id, merchant_id: amazon.id)
      invoice8 = Invoice.create!(status: 1, customer_id: travolta.id, merchant_id: amazon.id)
      invoice9 = Invoice.create!(status: 1, customer_id: sal.id, merchant_id: amazon.id)
      invoice10 = Invoice.create!(status: 1, customer_id: sal.id, merchant_id: amazon.id)
      invoice11 = Invoice.create!(status: 1, customer_id: tim.id, merchant_id: amazon.id)
      invoice13 = Invoice.create!(status: 0, customer_id: sally.id, merchant_id: amazon.id)
      invoice14 = Invoice.create!(status: 0, customer_id: sally.id, merchant_id: alibaba.id)
      tx1      = Transaction.create!(result: "success", credit_card_number: 010001001022, credit_card_expiration_date: 20251001, invoice_id: invoice2.id,)
      tx2      = Transaction.create!(result: "success", credit_card_number: 010001005555, credit_card_expiration_date: 20220101, invoice_id: invoice1.id,)
      tx3      = Transaction.create!(result: "success", credit_card_number: 010001005551, credit_card_expiration_date: 20220101, invoice_id: invoice3.id,)
      tx4      = Transaction.create!(result: "success", credit_card_number: 010001005552, credit_card_expiration_date: 20220101, invoice_id: invoice4.id,)
      tx5      = Transaction.create!(result: "success", credit_card_number: 010001005553, credit_card_expiration_date: 20220101, invoice_id: invoice5.id,)
      tx6      = Transaction.create!(result: "success", credit_card_number: 010001005554, credit_card_expiration_date: 20220101, invoice_id: invoice6.id,)
      tx7      = Transaction.create!(result: "success", credit_card_number: 010001005550, credit_card_expiration_date: 20220101, invoice_id: invoice7.id,)
      tx8      = Transaction.create!(result: "success", credit_card_number: 010001005556, credit_card_expiration_date: 20220101, invoice_id: invoice8.id,)
      tx9      = Transaction.create!(result: "success", credit_card_number: 010001005557, credit_card_expiration_date: 20220101, invoice_id: invoice9.id,)
      tx10     = Transaction.create!(result: "success", credit_card_number: 010001005523, credit_card_expiration_date: 20220101, invoice_id: invoice10.id,)
      tx11     = Transaction.create!(result: "success", credit_card_number: 0100010055, credit_card_expiration_date: 20220101, invoice_id: invoice11.id,)
      tx12     = Transaction.create!(result: "failure", credit_card_number: 0100010055, credit_card_expiration_date: 20220101, invoice_id: invoice14.id,)
      candle   = Item.create!(name: 'Lavender Candle', description: '8oz Soy Candle', unit_price: 7.0, merchant_id: amazon.id)
      backpack = Item.create!(name: 'Camo Backpack', description: 'Double Zip Backpack', unit_price: 15.5, merchant_id: alibaba.id)
      invitm1  = InvoiceItem.create!(status: 0, quantity: 25, unit_price: 7.0, invoice_id: invoice1.id, item_id: candle.id)
      invitm2  = InvoiceItem.create!(status: 0, quantity: 10, unit_price: 15.5, invoice_id: invoice2.id, item_id: backpack.id)

      expected_names = [sally.first_name, joel.first_name, john.first_name, travolta.first_name, sal.first_name]
      expected_successful_transaction_counts = [2, 2, 2, 2, 2]

      actual_names = amazon.top_five_customers.map do |customer|
        customer.first_name
      end

      actual_successful_transaction_counts = amazon.top_five_customers.map do |customer|
        customer.successful_transactions
      end

      expect(actual_names).to eq(expected_names)
      expect(actual_successful_transaction_counts).to eq(expected_successful_transaction_counts)
    end

    describe 'items_ready_to_ship' do
      it 'returns an array of all the names of my items that have been ordered and have not yet been shipped' do
        max = Merchant.create!(name: 'Merch Max')
        item_1 = max.items.create!(name: 'Beans', description: 'Tasty', unit_price: 5)
        item_2 = max.items.create!(name: 'Item 2', description: 'Blah', unit_price: 10)
        item_3 = max.items.create!(name: 'Item 3', description: 'Test', unit_price: 15)

        sally    = Customer.create!(first_name: 'Sally', last_name: 'Smith')
        invoice1 = Invoice.create!(status: 1, customer_id: sally.id, merchant_id: max.id)

        InvoiceItem.create!(invoice_id: invoice1.id, item_id: item_1.id, quantity: 1, unit_price: 5, status: 0)
        InvoiceItem.create!(invoice_id: invoice1.id, item_id: item_2.id, quantity: 1, unit_price: 10, status: 1)
        InvoiceItem.create!(invoice_id: invoice1.id, item_id: item_3.id, quantity: 1, unit_price: 15, status: 2)

        actual_items = max.items_ready_to_ship

        expected_items = [item_1, item_2]

        expect(actual_items).to eq(expected_items)
      end
    end
    describe 'order invoices' do
      it "can order by created_at date" do
        max = Merchant.create!(name: 'Merch Max')
        item_1 = max.items.create!(name: 'Beans', description: 'Tasty', unit_price: 5)
        item_2 = max.items.create!(name: 'Item 2', description: 'Blah', unit_price: 10)
        item_3 = max.items.create!(name: 'Item 3', description: 'Test', unit_price: 15)
        item_4 = max.items.create!(name: 'Item 4', description: 'Item 4 Description...', unit_price: 20)

        sally    = Customer.create!(first_name: 'Sally', last_name: 'Smith')
        lisa    = Customer.create!(first_name: 'Lisa', last_name: 'John')
        invoice1 = Invoice.create!(status: 1, customer_id: sally.id, merchant_id: max.id, created_at: '2010-02-21 09:54:09 UTC')
        invoice2 = Invoice.create!(status: 1, customer_id: lisa.id, merchant_id: max.id, created_at: '2012-03-25 09:54:09 UTC')

        InvoiceItem.create!(invoice_id: invoice1.id, item_id: item_1.id, quantity: 1, unit_price: 5, status: 0)
        InvoiceItem.create!(invoice_id: invoice1.id, item_id: item_2.id, quantity: 1, unit_price: 10, status: 1)
        InvoiceItem.create!(invoice_id: invoice1.id, item_id: item_3.id, quantity: 1, unit_price: 15, status: 2)
        InvoiceItem.create!(invoice_id: invoice2.id, item_id: item_4.id, quantity: 1, unit_price: 20, status: 1)

        actual = max.order_merchant_items_by_invoice_created_date(max.items)

        expected = [item_1, item_2, item_3, item_4]

        expect(actual).to eq(expected)
      end
    end
  end
end
