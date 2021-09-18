require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items).dependent(:destroy) }
  end

  before(:each) do
    @merchant = create(:merchant)
    @merchant_2 = create(:merchant, name: "Jennys Jewels", status: 'Enabled')
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

    describe 'update_status' do
      it 'updates merchant status' do
        @merchant_2.update_status('Disabled')
        expect(@merchant_2.status).to eq('Disabled')
        @merchant.update_status('Enabled')
        expect(@merchant.status).to eq('Enabled')
      end
    end
  end

  describe '#class methods' do
    it '#enabled_merchants' do
      expect(Merchant.enabled_merchants).to eq([@merchant_2])
    end

    it '#disabled_merchants' do
      expect(Merchant.disabled_merchants).to eq([@merchant])
    end
  end
end
