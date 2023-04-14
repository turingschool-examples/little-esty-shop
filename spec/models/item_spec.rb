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
      @item_1 = FactoryBot.create(:item, merchant: @merchant_1, status: 1)
      @item_2 = FactoryBot.create(:item, merchant: @merchant_1, status: 1)
      @item_3 = FactoryBot.create(:item, merchant: @merchant_1, status: 1)
      @item_4 = FactoryBot.create(:item, merchant: @merchant_1)
      @item_5 = FactoryBot.create(:item, merchant: @merchant_1)
    end

    it "enabled_items" do
      expect(@merchant_1.items.enabled_items).to eq([@item_1, @item_2, @item_3])
    end

    it "disabled_items" do
      expect(@merchant_1.items.disabled_items).to eq([@item_4, @item_5])
    end

    it "merchant_invoice_items_details" do
      test_data

      expect(@merchant_1.items.invoice_items_details(@invoice_1).first).to eq(@item_1)
      expect(@merchant_1.items.invoice_items_details(@invoice_1)).to eq([@item_1, @item_7])
    end
  end

  describe "class methods" do
     before do
      test_data
    end

    it "top_five_items" do
      expect(@merchant_3.items.top_five_items.all).to eq([@item_21, @item_20, @item_19, @item_18, @item_17,])
    end
  end
end