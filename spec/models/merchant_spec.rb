require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'class methods' do
    it '#top_five_customers' do
      expect(@merchant_1.top_five_customers).to eq([@customer_4, @customer_5, @customer_6, @customer_3, @customer_2])
    end

    it '#items_ready_to_ship' do
      packaged_items = [@item_5, @item_6, @item_7, @item_8, @item_9, @item_10, @item_1, @item_2, @item_3, @item_4, @item_5]
      expect(@merchant_1.items_ready_to_ship).to eq(packaged_items.sort)
    end
  end
end
