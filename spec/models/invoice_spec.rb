require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'instance methods' do
    it 'can order invoice by date' do
      customer_1 = Customer.create!(first_name: "A", last_name: "A")

      invoice_1 = Invoice.create!(status: "completed", customer_id: customer_1.id, created_at: "2012-03-26 09:54:49 UTC")
      invoice_2 = Invoice.create!(status: "in progress", customer_id: customer_1.id, created_at: "2012-03-27 05:54:50 UTC")
      invoice_3 = Invoice.create!(status: "in progress", customer_id: customer_1.id, created_at: "2012-03-22 21:54:50 UTC")

      merchant = Merchant.create!(name: "Wizards Chest")

      item1 = Item.create!(name: "A", description: "A", unit_price: 100, merchant_id: merchant.id)
      item2 = Item.create!(name: "B", description: "B", unit_price: 250, merchant_id: merchant.id)

      invoice_item_1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice_1.id, status: "packaged", quantity: 5, unit_price: 100)
      invoice_item_2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice_2.id, status: "pending", quantity: 5, unit_price: 100)
      invoice_item_3 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice_3.id, status: "pending", quantity: 5, unit_price: 100)

      expect(Invoice.all.order_by_date).to eq([invoice_2, invoice_1, invoice_3])
    end
  end
end
