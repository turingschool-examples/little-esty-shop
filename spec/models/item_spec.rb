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

      @item_1 = create(:item, merchant: @merchant, status: "Disabled")
      @item_2 = create(:item, merchant: @merchant)
      @item_3 = create(:item, merchant: @merchant)
      @item_4 = create(:item, merchant: @merchant)
    end

    describe '::enabled' do
      it 'returns the top five customers, ordered by successful transactions' do
        expect(@merchant.items.enabled).to eq([@item_2, @item_3, @item_4])
      end
    end

    describe "::disabled" do
      it "returns all ordered items that have not been shiped from oldest to newest" do
        expect(@merchant.items.disabled).to eq([@item_1])
      end
    end
  end
end
