require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to :merchant }
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices).through(:invoice_items) }

  describe '::top_five' do
    it 'returns the top 5 highest selling items' do
      merchant = Merchant.create!(name: 'merchant name')
      item_1 = Item.create!(merchant_id: merchant.id, name: 'widget-1', description: 'widget description', unit_price: 100)
      item_2 = Item.create!(merchant_id: merchant.id, name: 'widget-2', description: 'widget description', unit_price: 200)
      item_3 = Item.create!(merchant_id: merchant.id, name: 'widget-3', description: 'widget description', unit_price: 300)
      item_4 = Item.create!(merchant_id: merchant.id, name: 'widget-4', description: 'widget description', unit_price: 400)
      item_5 = Item.create!(merchant_id: merchant.id, name: 'widget-5', description: 'widget description', unit_price: 500)
      item_6 = Item.create!(merchant_id: merchant.id, name: 'widget-6', description: 'widget description', unit_price: 600)
      item_7 = Item.create!(merchant_id: merchant.id, name: 'widget-7', description: 'widget description', unit_price: 700)
      item_8 = Item.create!(merchant_id: merchant.id, name: 'widget-8', description: 'widget description', unit_price: 800)
      item_9 = Item.create!(merchant_id: merchant.id, name: 'widget-9', description: 'widget description', unit_price: 900)
      item_10 = Item.create!(merchant_id: merchant.id, name: 'widget-10', description: 'widget description', unit_price: 1000)
      customer_1 = Customer.create!(first_name: 'customer', last_name: 'customer_last_name')
      invoice_1 = Invoice.create!(customer_id: customer_1.id)
      invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_10.id, quantity: 20,
                                           unit_price: 1000)
      invoice_item_2 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_9.id, quantity: 20,
                                           unit_price: 900)
      invoice_item_3 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_8.id, quantity: 20,
                                           unit_price: 800)
      invoice_item_4 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_7.id, quantity: 20,
                                           unit_price: 700)
      invoice_item_5 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_6.id, quantity: 20,
                                           unit_price: 600)
      invoice_item_6 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_5.id, quantity: 20,
                                           unit_price: 500)
      invoice_item_8 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_4.id, quantity: 20,
                                           unit_price: 400)
      invoice_item_9 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_3.id, quantity: 20,
                                           unit_price: 300)
      invoice_item_10 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 20,
                                           unit_price: 200)
      invoice_item_10 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 20,
                                           unit_price: 100)
      Transaction.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success", created_at: "2012-03-27 14:54:09", updated_at: "2012-03-27 14:54:09", invoice_id: invoice_1.id)
      actual = Item.top_five
      Transaction.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "failed", created_at: "2012-03-27 14:54:09", updated_at: "2012-03-27 14:54:09", invoice_id: invoice_1.id)
      actual = Item.top_five
      expected = [item_10, item_9, item_8, item_7, item_6,]
      expect(actual).to eq(expected)
    end
  end
end
