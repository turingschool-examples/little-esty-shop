require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
  end


  describe 'Class Methods' do   
    describe '.not_shipped' do 
        it 'sorts by status when not shipped' do
          stephen = Merchant.create!(name: "Stephen's shop")

          customer1 = Customer.create!(first_name: "Abdul", last_name: "Redd")

          item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: stephen.id) 
          item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: stephen.id) 
          item3 = Item.create!(name: "Boulder", description: "It's a literal rock", unit_price: 3500, merchant_id: stephen.id) 

          invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
          invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
          
          invoice_item1 = InvoiceItem.create!(quantity:100, unit_price: 1500, status: "pending", item_id: item1.id, invoice_id: invoice1.id)
          invoice_item2 = InvoiceItem.create!(quantity:100, unit_price: 2500, status: "packaged", item_id: item2.id, invoice_id: invoice1.id)
          invoice_item3 = InvoiceItem.create!(quantity:100, unit_price: 3500, status: "shipped", item_id: item3.id, invoice_id: invoice2.id)

          expect(stephen.not_shipped).to eq([item1,item2])
        end 
      end
  end
end
