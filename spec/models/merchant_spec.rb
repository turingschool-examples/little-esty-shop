require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'class methods' do
  #   it '#top_five_customers' do
  #     expect(@merchant_1.top_five_customers).to eq([@customer_2, @customer_3, @customer_4, @customer_5, @customer_6])
  #   end
    it '#items_ready_to_ship' do
      expect(@merchant_1.items_ready_to_ship).to eq([@item_1, @item_2, @item_3, @item_4])
    end
  end
end
