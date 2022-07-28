require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'model methods' do 
    # it 'calculates items ready to ship' do
    #   merchant1 = Merchant.create!(name: 'Fake Merchant')

    #   item1 = merchant1.items.create!(name: 'Coaster', description: 'For day drinking', unit_price: 74344)
    #   item2 = merchant1.items.create!(name: 'Tongs', description: 'For ice buckets', unit_price: 98334)

    #   customer1 = Customer.create!(first_name: 'Bob', last_name: 'Smith')

    #   invoice1 = customer1.invoices.create!(status: 2)
    #   invoice2 = customer1.invoices.create!(status: 2)
    #   invoice3 = customer1.invoices.create!(status: 0)

    #   invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 43434, status: 1)
    #   invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 4, unit_price: 43434, status: 1)
    #   invoice_item3 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice3.id, quantity: 4, unit_price: 43434, status: 0)
    #   invoice_item4 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice3.id, quantity: 4, unit_price: 43434, status: 2)

    #   expect(Item.ready_to_ship(merchant1.id).pluck(:name)).to eq([item1.name, item2.name])
    # end
  end
end
