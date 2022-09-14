require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should belong_to(:merchant)}
  end

  before :each do
    @item1 = create(:item, unit_price: 5700)
    @item2 = create(:item)
  end

  describe 'instance methods' do
    it '#price_convert' do
      expect(@item1.price_convert).to eq("57.00")
    end
  end
end
