require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }

  end

  describe 'methods' do 
    it 'has items ready to ship' do 
      merchant1 = Merchant.create!(name: 'Fake Merchant')

      item1 = merchant1.items.create!(name: 'Coaster', description: 'For day drinking', unit_price: 74344)
      item2 = merchant1.items.create!(name: 'Tongs', description: 'For ice buckets', unit_price: 98334)

      customer1 = Customer.create!(first_name: 'Bob', last_name: 'Smith')

      invoice1 = customer1.invoices.create!(status: 'in progress')
      invoice2 = customer1.invoices.create!(status: 'completed')

      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 43434, status: 'pending')
      invoice_item2 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice2.id, quantity: 4, unit_price: 43434, status: 'shipped')

      expect(merchant1.items_ready_to_ship.name).to eq(item1.name)
    end
  end
end
