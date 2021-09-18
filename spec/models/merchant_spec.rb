require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items).dependent(:destroy) }
  end

  before(:each) do
    @merchant = create(:merchant)
    @disabled_item_1 = create(:item, merchant: @merchant)
    @disabled_item_2 = create(:item, merchant: @merchant)
    @enabled_item_1  = create(:item, merchant: @merchant, status: 'Enabled')
    @enabled_item_2  = create(:item, merchant: @merchant, status: 'Enabled')
  end

  describe '#instance methods' do
    describe 'enabled items' do
      it 'returns the merchants enabled items' do
        expect(@merchant.enabled_items).to eq([@enabled_item_1, @enabled_item_2])
      end
    end

    describe 'disabled items' do
      it 'returns the merchants disabled items' do
        expect(@merchant.disabled_items).to eq([@disabled_item_1, @disabled_item_2])
      end
    end
  end
end
