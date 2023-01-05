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

    it 'returns the items in order of oldest to newest' do
      merchants_ready_items = Merchant.find(1).ready_to_ship_items
      first_item = merchants_ready_items.first
      second_item = merchants_ready_items.second
      last_item = merchants_ready_items.last

      expect(first_item.invoice_created_at < second_item.invoice_created_at).to eq true
      expect(second_item.invoice_created_at < last_item.invoice_created_at).to eq true
    end
  end

  describe '#top_5_by_revenue' do
    it 'returns the top 5 merchants by revenue' do
      expect(Merchant.top_5_by_revenue).to eq([Merchant.find(8), Merchant.find(2), Merchant.find(7), Merchant.find(3), Merchant.find(4)])
    end
  end

  describe '#get_enabled_items' do
    it 'returns all of a merchants enabled items' do
      merchant = Merchant.find(1)
      expect(merchant.get_enabled_items).to eq(merchant.items)
      expect(merchant.get_enabled_items.length).to eq(15)
      Item.find(1).update(enabled: false)
      expect(merchant.get_enabled_items.length).to eq(14)
    end
  end

  describe '#get_disabled_items' do
    it 'returns all of a merchants disabled items' do
      merchant = Merchant.find(1)
      expect(merchant.get_disabled_items.length).to eq(0)
      item_1 = merchant.items.create!(name: "bob", description: "very good at things", unit_price: 9999, enabled: false)
      item_2 = merchant.items.create!(name: "bob2", description: "very better at things", unit_price: 99999, enabled: false)
      item_3 = merchant.items.create!(name: "bob3", description: "very best at things", unit_price: 99999, enabled: false)
      item_4 = merchant.items.create!(name: "bob4", description: "very okay at things", unit_price: 999, enabled: false)
      expect(merchant.get_disabled_items).to eq([item_1, item_2, item_3, item_4])
    end
  end
end