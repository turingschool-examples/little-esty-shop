require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end

  describe '::total_revenue' do
    it 'returns the total expected revenue from a given invoice' do
      customer = Customer.create!(first_name: 'Bob', last_name: 'Dylan')
      merchant = Merchant.create!(name: 'Jen')
      invoice = Invoice.create!(customer_id: customer.id, status: 'completed')
      item1 = Item.create!(name: 'Pumpkin', description: 'Orange', unit_price: 3, merchant_id: merchant.id)
      item2 = Item.create!(name: 'Pillow', description: 'Soft', unit_price: 20, merchant_id: merchant.id)
      invoice_item = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice.id, quantity: 10, unit_price: 30, status: 'shipped')
      invoice_item = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice.id, quantity: 2, unit_price: 40, status: 'shipped')

      expect(InvoiceItem.total_revenue(invoice)).to eq(70)
    end
  end
end
