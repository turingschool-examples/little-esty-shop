require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many(:items) }
  it { should have_many(:invoices).through(:items)}
  it { should validate_presence_of(:name)}

  before :each do
    test_data
  end

  describe 'instance methods' do
    it '#enabled_items' do
      expect(@merchant_1.enabled_items).to eq([@item_1, @item_9])
      expect(@merchant_1.enabled_items).to_not eq([@item_2, @item_3])
      expect(@merchant_2.enabled_items).to eq([@item_2, @item_10])
      expect(@merchant_2.enabled_items).to_not eq([@item_1, @item_3])
      @item_1.update(status: 1)
      expect(@merchant_1.enabled_items).to eq([@item_9])
      expect(@merchant_1.enabled_items).to_not eq([@item_1, @item_9])
    end

    it '#disabled_items' do
      expect(@merchant_1.disabled_items).to eq([])
      expect(@merchant_2.disabled_items).to eq([])
      @item_1.update(status: 1)
      @item_2.update(status: 1)
      expect(@merchant_1.disabled_items).to eq([@item_1])
      expect(@merchant_1.disabled_items).to_not eq([@item_9])
    end
  end
end
