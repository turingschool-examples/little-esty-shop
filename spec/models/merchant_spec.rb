require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'instance methods' do
    it 'can order items by least recent invoice' do
      merchant = Merchant.create!(name: 'Trinkets and Tinctures')

      customer1 = Customer.create!(first_name: 'Theophania', last_name: 'Fenwick')
      customer2 = Customer.create!(first_name: 'Vera', last_name: 'Wynn')

      item1 = merchant.items.create!(name: 'Copper Bracelet', description: 'Shiny, but not too shiny', unit_price: 20)
      item2 = merchant.items.create!(name: 'Copper Ring', description: 'Shiny, but not too shiny', unit_price: 10)
      item3 = merchant.items.create!(name: 'Lemongrass Extract', description: 'Smells citrus', unit_price: 6)

      invoice1 = customer1.invoices.create!(status: 1)
      invoice2 = customer2.invoices.create!(status: 1)

      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item3)
      invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item1)
      invoice_item3 = InvoiceItem.create!(invoice: invoice2, item: item2)
      invoice_item4 = InvoiceItem.create!(invoice: invoice1, item: item2)

      expect(merchant.items_ready_to_ship).to eq([invoice_item1, invoice_item4, invoice_item2, invoice_item3])
    end
  end
end

