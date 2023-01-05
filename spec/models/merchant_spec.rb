require 'rails_helper'

RSpec.describe Merchant do
  describe 'Relationships' do
    it { should have_many :items }
    it { should have_many(:invoices).through(:items) }
  end

  describe 'instance methods' do
    it '#packaged_items' do
      merchant = Merchant.create!(name: 'Rays Hand Made Jewlery')
      item1 = Item.create!(name: 'Chips', description: 'Ring', unit_price: 20, merchant_id: merchant.id)
      item2 = Item.create!(name: 'darrel', description: 'Bracelet', unit_price: 40, merchant_id: merchant.id)
      item3 = Item.create!(name: 'don', description: 'Necklace', unit_price: 30, merchant_id: merchant.id)

      customer = Customer.create!(first_name: 'Kyle', last_name: 'Ledin')
      invoice = Invoice.create!(status: 1, customer_id: customer.id)
      ii1 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id,
                                 invoice_id: invoice.id)
      ii2 = InvoiceItem.create!(quantity: 5, unit_price: item2.unit_price, item_id: item2.id,
                                 invoice_id: invoice.id)
      ii3 = InvoiceItem.create!(quantity: 5, unit_price: item3.unit_price, item_id: item3.id,
                                 invoice_id: invoice.id)
      expect(merchant.packaged_items).to eq([item1, item2, item3])
    end
  end
end
