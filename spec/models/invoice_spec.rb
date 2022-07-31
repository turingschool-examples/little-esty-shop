require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of :status }
    it { should define_enum_for(:status).with_values('in progress' => 0, 'cancelled' => 1, 'completed' => 2) }
  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  ###merchant invoice total revenue model method###
  describe "model methods" do 
    it 'calculates total revenue of merchant invoice' do
      merchant1 = Merchant.create!(name: 'Fake Merchant')
      merchant2 = Merchant.create!(name: 'Another Merchant')

      item1 = merchant1.items.create!(name: 'Coaster', description: 'For day drinking', unit_price: 74344)
      item2 = merchant1.items.create!(name: 'Tongs', description: 'For ice buckets', unit_price: 98334)
      item3 = merchant1.items.create!(name: 'knife', description: 'kitchen essential', unit_price: 28839)
      item4 = merchant1.items.create!(name: 'football', description: 'sports', unit_price: 299839)
      
      customer1 = Customer.create!(first_name: 'Robert', last_name: 'Smith')
      customer2 = Customer.create!(first_name: 'Suzie', last_name: 'Hill')
      customer3 = Customer.create!(first_name: 'Roger', last_name: 'Mathis')
      customer4 = Customer.create!(first_name: 'Jimmy', last_name: 'Ray')
      

      invoice1 = customer1.invoices.create!(status: 2)
      invoice2 = customer2.invoices.create!(status: 2)
      invoice3 = customer3.invoices.create!(status: 2)
      invoice4 = customer4.invoices.create!(status: 2)
  

      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 43434, status: 1)
      invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 5, unit_price: 87654, status: 1)
      invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 6, unit_price: 65666, status: 0)
      invoice_item4 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice4.id, quantity: 7, unit_price: 65666, status: 2)
      
      expect(invoice1.total_rev).to eq(612006)
    end
  end
end
