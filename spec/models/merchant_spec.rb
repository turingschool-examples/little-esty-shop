require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name}
  end
  describe "relationships" do
     it { should have_many :items }
  end

  describe 'instance methods' do
    it '#most_popular_items' do

      merchant1 = create(:merchant)
      customer1 = create(:customer)

      invoice1 = create(:invoice, customer: customer1, status: 1)
      invoice2 = create(:invoice, customer: customer1, status: 1)

      transaction1 = create(:transaction, invoice: invoice1, result: 'success')
      transaction2 = create(:transaction, invoice: invoice2, result: 'failed')

      item1 = create(:item, merchant: merchant1, unit_price: 1)
      item2 = create(:item, merchant: merchant1, unit_price: 2)
      item3 = create(:item, merchant: merchant1, unit_price: 3)
      item4 = create(:item, merchant: merchant1, unit_price: 4)
      item5 = create(:item, merchant: merchant1, unit_price: 5)
      item6 = create(:item, merchant: merchant1, unit_price: 6)

      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 1, unit_price: 300) #300 rev
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoice1, quantity: 2, unit_price: 10) #20 rev
      invoice_item3 = create(:invoice_item, item: item3, invoice: invoice1, quantity: 3, unit_price: 10) #30 rev
      invoice_item4 = create(:invoice_item, item: item4, invoice: invoice1, quantity: 1, unit_price: 10) #10 rev
      invoice_item5 = create(:invoice_item, item: item5, invoice: invoice1, quantity: 5, unit_price: 10) #50 rev
      invoice_item6 = create(:invoice_item, item: item6, invoice: invoice2, quantity: 6, unit_price: 10) #60 rev

#      expected = [item1,item5,item3,item2,item4]
      expect(merchant1.most_popular_items[0]).to eq(item1)
      expect(merchant1.most_popular_items[1]).to eq(item5)
      expect(merchant1.most_popular_items[2]).to eq(item3)
      expect(merchant1.most_popular_items[3]).to eq(item2)
      expect(merchant1.most_popular_items[4]).to eq(item4)
    end
  
    it "#unshipped_invoice_items returns a merchant's invoice items with unshipped status" do
      merchant = Merchant.create(name: "Need a Merchant")
      item_1 = merchant.items.create!(name: "spoon", description: "stamped stainless steel, not deburred", unit_price: 80, status: 1, merchant_id: merchant.id)
      item_2 = merchant.items.create!(name: "fork", description: "stamped stainless steel, not deburred", unit_price: 90, status: 1, merchant_id: merchant.id)
      customer_1 = Customer.create(first_name: "Max", last_name: "Powers")
      invoice_1 = customer_1.invoices.create!(status: 0)
      invoice_2 = customer_1.invoices.create!(status: 0)
      association_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price:75, status:0)
      association_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 3, unit_price:77, status:1)
      association_2 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, quantity: 3, unit_price:77, status:2)

      expected_collection = merchant.unshipped_invoice_items
      expect(expected_collection.length).to eq(2)
      expect(expected_collection.pluck(:name).include?(item_1.name)).to eq(true)
      expect(expected_collection.pluck(:name).include?(item_2.name)).to eq(true)
      
    end
  end
end
