require 'rails_helper'

RSpec.describe Merchant do
  before(:each) do
    @gary = Merchant.first
    @item_1 = @gary.items.create!(name: "Shirt", description: "Gary wears it", unit_price: 55, enabled: "enabled")
    @item_2 = @gary.items.create!(name: "Pants", description: "Gary does not wear it", unit_price: 6, enabled: "disabled")
  end

  describe 'relationships' do
    it {should have_many :items}
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
    it 'collects enabled items' do
      expect(@gary.enabled_items).to eq([@item_1])
    end


    it 'collects disabled items' do
      expect(@gary.disabled_items).to eq([@item_2])
    end
  end
end
