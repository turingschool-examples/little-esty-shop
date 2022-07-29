require 'rails_helper'

RSpec.describe Item do
  describe 'instance methods' do
    it 'has most sales date (best day)' do
      customer = Customer.create!(first_name: "A", last_name: "A")

      invoice_1 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-22 00:00:00 UTC") #failed
      invoice_2 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-22 00:00:00 UTC") #item2 7/22
      invoice_3 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-25 00:00:00 UTC")
      invoice_4 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-25 00:00:00 UTC")
      invoice_5 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-26 00:00:00 UTC")
      invoice_6 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-26 00:00:00 UTC") #item1 7/26
      invoice_7 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-28 00:00:00 UTC") #failed
      invoice_8 = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-28 00:00:00 UTC") #failed

      transaction_1 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_1.id)
      transaction_2 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_2.id)
      transaction_3 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_3.id)
      transaction_4 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
      transaction_5 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_5.id)
      transaction_6 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
      transaction_7 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_7.id)
      transaction_8 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_8.id)

      merchant = Merchant.create!(name: "Wizards Chest")

      item_1 = Item.create!(name: "A", description: "A", unit_price: 100, merchant_id: merchant.id)
      item_2 = Item.create!(name: "B", description: "B", unit_price: 200, merchant_id: merchant.id)

      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: "pending", quantity: 90, unit_price: 100)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: "pending", quantity: 20, unit_price: 100) #2
      invoice_item_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_5.id, status: "pending", quantity: 5, unit_price: 100) #1
      invoice_item_4 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_6.id, status: "pending", quantity: 5, unit_price: 100) #1
      invoice_item_5 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_7.id, status: "pending", quantity: 90, unit_price: 100)
      invoice_item_6 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_8.id, status: "pending", quantity: 90, unit_price: 100)
      invoice_item_7 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_3.id, status: "pending", quantity: 5, unit_price: 100)
      invoice_item_8 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_4.id, status: "pending", quantity: 5, unit_price: 100)
      invoice_item_9 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_7.id, status: "pending", quantity: 90, unit_price: 100)
      invoice_item_10 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_8.id, status: "pending", quantity: 90, unit_price: 100)
      
      expect(item_1.most_sales_date).to eq(invoice_5.created_at.strftime("%m/%d/%y"))
      expect(item_2.most_sales_date).to eq(invoice_2.created_at.strftime("%m/%d/%y"))
    end
  end
end