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
  end
end
