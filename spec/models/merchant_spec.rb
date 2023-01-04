require 'rails_helper'

RSpec.describe Merchant do
  describe 'Relationships' do
    it {should have_many :items}    
    it {should validate_presence_of :name}
  end

  describe '#top_five_customers' do
    it 'returns the top 5 customers with most successful transactions with given merchant' do
      top5 = Merchant.find(2).top_five_customers

      expect(top5.length).to eq(5)
      expect(top5).to eq([Customer.find(12), Customer.find(10), Customer.find(1), Customer.find(3), Customer.find(11)])
      expect(top5[0].transaction_count).to eq(9)
      expect(top5[4].transaction_count).to eq(3)
    end
  end

  describe '#ready_to_ship_items' do
    it 'returns the items that are ordered but not shipped for the given merchant' do
      merchants_ready_items = Merchant.find(1).ready_to_ship_items

      merchants_ready_items.each do |item|
        expect(item).to be_a Item
        expect(item.merchant_id).to eq(1)
        expect(item.status).to eq(1)
      end   
      
      expect(merchants_ready_items.length).to eq(16)
    end
  end

  describe '#group by enabled' do
    it 'Groups merchants by enabled true' do
      expect(Merchant.group_by_enabled).to eq([Merchant.find(1), Merchant.find(2), Merchant.find(3), Merchant.find(4), Merchant.find(5), Merchant.find(6), Merchant.find(7), Merchant.find(8), Merchant.find(9), Merchant.find(10)])
    end

    it 'Groups merchant by enabled false' do

      Merchant.find(1).update!(enabled: false)
      expect(Merchant.group_by_not_enabled).to eq([Merchant.find(1)])
      Merchant.find(1).update!(enabled: true)
      expect(Merchant.group_by_not_enabled).to eq([])
    end
  end
end