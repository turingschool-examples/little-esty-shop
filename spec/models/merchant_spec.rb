require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
  end

  before(:each) do
    @merchant = Merchant.first
  end

  describe '#top_customers' do
    it 'returns the top 5 customers for the given merchant' do

      expect(@merchant.top_customers.length).to eq(5)
    end
  end

  describe '#shippable_items' do
    it 'returns the items that are ready to ship in order from oldest to newest' do

      expect(@merchant.shippable_items).to be_a(Array)
      expect(@merchant.shippable_items.length).to eq(21)
      expect(@merchant.shippable_items[0][0]).to eq("Item Quo Magnam")
      expect(@merchant.shippable_items[0][2]).to be < @merchant.shippable_items[20][2]
    end
  end
end
