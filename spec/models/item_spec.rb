require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant}
    it { should have_many :invoice_items}
    it { should have_many(:invoices).through(:invoice_items)}
  end

  describe "class methods" do
    before do
      @merchant_1 = FactoryBot.create(:merchant)
      @item_1 = FactoryBot.create(:item, merchant: @merchant_1)
      @item_2 = FactoryBot.create(:item, merchant: @merchant_1)
      @item_3 = FactoryBot.create(:item, merchant: @merchant_1)
      @item_4 = FactoryBot.create(:item, merchant: @merchant_1, status: 0)
      @item_5 = FactoryBot.create(:item, merchant: @merchant_1, status: 0)
    end

    it "enabled_items" do
      expect(@merchant_1.items.enabled_items).to eq([@item_1, @item_2, @item_3])
    end

    it "disabled_items" do
      expect(@merchant_1.items.disabled_items).to eq([@item_4, @item_5])
    end
  end
end