require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it { should belong_to :merchant }
  end

  describe 'instance methods' do
    it 'can return total revenue generated' do
      merchant = Merchant.create!(name: 'Trinkets and Tinctures')

      customer = Customer.create!(first_name: 'Theophania', last_name: 'Fenwick')

      item = merchant.items.create!(name: 'Copper Bracelet', description: 'Shiny, but not too shiny', unit_price: 20)

      invoice = customer.invoices.create!(status: 2)
      invoice2 = customer.invoices.create!(status: 0)

      invoice_item = InvoiceItem.create!(invoice: invoice, item: item, quantity: 2, unit_price: 20, status: 2)
      invoice_item = InvoiceItem.create!(invoice: invoice2, item: item, quantity: 2, unit_price: 20, status: 1)

      expect(item.total_revenue).to eq(40)
    end
  end
end

