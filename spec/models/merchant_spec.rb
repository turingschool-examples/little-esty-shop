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

      expect(@merchant.shippable_items.length).to eq(21)
      expect(@merchant.shippable_items.first.name).to eq("Item Expedita Aliquam")
      expect(@merchant.shippable_items.first.invoice_created_at).to be < @merchant.shippable_items.last.invoice_created_at
    end
  end
end
