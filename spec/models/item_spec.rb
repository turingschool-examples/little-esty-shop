require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'class methods' do
    before(:each) do
      @merchant = create(:merchant)
      @item1 = create :item, { merchant_id: @merchant.id, status: 'enabled' }
      @item2 = create :item, { merchant_id: @merchant.id }
    end
    describe '.item_status' do
      it 'returns recrods where the status equals the argument' do
        expect(Item.item_status('enabled')).to eq([@item1])
        expect(Item.item_status('disabled')).to eq([@item2])
      end
    end
  end
end
