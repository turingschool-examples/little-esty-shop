require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'instance methods' do
    it 'can format the created at date' do
      merchant = Merchant.create!(name: 'Trinkets and Tinctures')

      customer1 = Customer.create!(first_name: 'Theophania', last_name: 'Fenwick')

      item1 = merchant.items.create!(name: 'Copper Bracelet', description: 'Shiny, but not too shiny', unit_price: 20)
      item2 = merchant.items.create!(name: 'Copper Ring', description: 'Shiny, but not too shiny', unit_price: 10)
      item3 = merchant.items.create!(name: 'Lemongrass Extract', description: 'Smells citrus', unit_price: 6)

      invoice1 = customer1.invoices.create!(status: 1, created_at: '2022-07-26 01:08:32 UTC')

      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item3, quantity: 1, unit_price: 6, status: 1)
      invoice_item2 = InvoiceItem.create!(invoice: invoice1, item: item2, quantity: 1, unit_price: 10, status: 1)

      expect(invoice1.formatted_date).to eq('Tuesday, July 26, 2022')
    end
    it 'can return a string of the customers full name' do
      customer1 = Customer.create!(first_name: 'Theophania', last_name: 'Fenwick')
      invoice1 = customer1.invoices.create!(status: 1, created_at: '2022-07-26 01:08:32 UTC')

      expect(invoice1.customer_name).to eq('Theophania Fenwick')
    end
  end
end

