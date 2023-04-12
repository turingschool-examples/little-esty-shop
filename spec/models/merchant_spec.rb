require 'rails_helper'

RSpec.describe Invoice, type: :model do

  describe 'relationships' do
    it { should have_many :items }
  end

  describe '#instance methods' do
    before(:each) do
      test_data
    end

    it 'can find top 5 customers' do
      expect(@merchant_1.top_five_customers).to eq([@customer_6, @customer_5, @customer_1, @customer_2, @customer_3])  

      @invoice_21 = Invoice.create!(customer_id: @customer_5.id, status: 1)
      @invoice_22 = Invoice.create!(customer_id: @customer_5.id, status: 1)
      @invoice_23 = Invoice.create!(customer_id: @customer_5.id, status: 1)
      @invoice_24 = Invoice.create!(customer_id: @customer_5.id, status: 1)
      @invoice_25 = Invoice.create!(customer_id: @customer_5.id, status: 1)
      @invoice_item_21 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_21.id, quantity: 1, unit_price: 100, status: 1)
      @invoice_item_22 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_22.id, quantity: 1, unit_price: 100, status: 1)
      @invoice_item_23 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_23.id, quantity: 1, unit_price: 100, status: 1)
      @invoice_item_24 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_24.id, quantity: 1, unit_price: 100, status: 1)
      @invoice_item_25 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_25.id, quantity: 1, unit_price: 100, status: 1)
      @transaction_21 = Transaction.create!(invoice_id: @invoice_21.id, credit_card_number: 1234567890123456, credit_card_expiration_date: 2020-01-01, result: 1)
      @transaction_22 = Transaction.create!(invoice_id: @invoice_22.id, credit_card_number: 1234567890123456, credit_card_expiration_date: 2020-01-01, result: 1)
      @transaction_23 = Transaction.create!(invoice_id: @invoice_23.id, credit_card_number: 1234567890123456, credit_card_expiration_date: 2020-01-01, result: 1)
      @transaction_24 = Transaction.create!(invoice_id: @invoice_24.id, credit_card_number: 1234567890123456, credit_card_expiration_date: 2020-01-01, result: 1)
      @transaction_25 = Transaction.create!(invoice_id: @invoice_25.id, credit_card_number: 1234567890123456, credit_card_expiration_date: 2020-01-01, result: 1)

      expect(@merchant_1.top_five_customers).to eq([@customer_5, @customer_6, @customer_1, @customer_2, @customer_3])
    end
  end
end