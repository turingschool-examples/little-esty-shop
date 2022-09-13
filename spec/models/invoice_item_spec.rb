require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do

    it {should belong_to(:item)}
    it {should belong_to(:invoice)}

  end

  describe 'enums' do

    it 'response to status methods' do
      customer = Customer.create!(first_name: "Gunther", last_name: "Guyman")
      invoice = Invoice.create!(customer_id: customer.id, status: 0)
      merchant = Merchant.create!(name: "Phrank")
      item = Item.create!(name: "Cool Pencil", description: "See name", unit_price: 5000, merchant_id: merchant.id)
      invoice_item = InvoiceItem.create!(invoice_id: invoice.id, item_id: item.id, quantity: 2, unit_price: item.unit_price, status: 0)

      expect(invoice_item.pending?).to eq(true)

      invoice_item.shipped!
      expect(invoice_item.pending?).to eq(false)
    end


  end
end
