require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it { should belong_to :merchant }
  end

  describe 'methods' do
    it 'displays the top sales day for each of the top items' do
      merchant1 = Merchant.create!(name: "Snake Shop")
      
      customer = Customer.create!(first_name: "Alep", last_name: "Bloyd")

      item1_merchant1 = Item.create!(name: "Snake Pants", description: "It is just a sock.", unit_price: 400, merchant_id: merchant1.id)
        invoice1 = Invoice.create!(customer_id: customer.id, status: 2, created_at: DateTime.new(1992,5,3)) # 20 in sales on May 3 1992
          invoiceitem1_item1_invoice1 = InvoiceItem.create!(item_id: item1_merchant1.id, invoice_id: invoice1.id, quantity: 10, unit_price: 1, status: 0)
          invoiceitem2_item1_invoice1 = InvoiceItem.create!(item_id: item1_merchant1.id, invoice_id: invoice1.id, quantity: 10, unit_price: 1, status: 0)

          transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 2222_3333_4444_5555, credit_card_expiration_date: "05-19-1992", result: 1) #successful

        invoice2 = Invoice.create!(customer_id: customer.id, status: 2, created_at: DateTime.new(1998,12,12)) # 30 in sales on December 12, 1998

          invoiceitem1_item1_invoice2 = InvoiceItem.create!(item_id: item1_merchant1.id, invoice_id: invoice2.id, quantity: 10, unit_price: 1, status: 0)
          invoiceitem2_item1_invoice2 = InvoiceItem.create!(item_id: item1_merchant1.id, invoice_id: invoice2.id, quantity: 10, unit_price: 1, status: 0)
          invoiceitem2_item1_invoice2 = InvoiceItem.create!(item_id: item1_merchant1.id, invoice_id: invoice2.id, quantity: 10, unit_price: 1, status: 0)

          transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 2222_3333_4444_5555, credit_card_expiration_date: "05-19-1992", result: 1) #successful

        invoice3 = Invoice.create!(customer_id: customer.id, status: 2, created_at: DateTime.new(2001,3,2)) # March 2, 2001 - a big failed transaction
          invoiceitem1_item1_invoice3 = InvoiceItem.create!(item_id: item1_merchant1.id, invoice_id: invoice3.id, quantity: 1000, unit_price: 1, status: 0)

          transaction2 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: 2222_3333_4444_5555, credit_card_expiration_date: "05-19-1992", result: 0) #failed transaction

      expect(item1_merchant1.best_date).to eq("December 12, 1998")
    end
  end
end