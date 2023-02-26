require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Associations' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end
  
  describe '::Class Methods' do
    before(:each) do
      @merchant = create(:merchant, name: "Trader Bob's")

      @item_1 = create(:item, merchant: @merchant)
      @item_2 = create(:item, merchant: @merchant, status: "Enabled")
      @item_3 = create(:item, merchant: @merchant, status: "Enabled")
      @item_4 = create(:item, merchant: @merchant, status: "Enabled")
    end

    describe '::enabled' do
      it 'returns all items where the status is enabled' do
        expect(@merchant.items.enabled).to eq([@item_2, @item_3, @item_4])
        expect(@merchant.items.enabled).to_not eq([@item_1])
      end
    end

    describe "::disabled" do
      it "returns all items where the status is disabled" do
        expect(@merchant.items.disabled).to eq([@item_1])
        expect(@merchant.items.disabled).to_not eq([@item_2, @item_3, @item_4])
      end
    end
  end
end
