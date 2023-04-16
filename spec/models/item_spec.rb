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

    it "top_day" do
      @invoice_12.update(created_at: 10.day.ago)
      @invoice_item_50.update(quantity: 10)
      @invoice_7.update(created_at: 2.day.ago)
      @item_19.update(created_at: 5.day.ago)
      @item_18.update(created_at: 14.day.ago)
      @item_17.update(created_at: 8.day.ago)
      expect(@item_21.top_day).to eq("04/04/2023")
      expect(@item_20.top_day).to eq("04/12/2023")
      expect(@item_19.top_day).to eq("04/09/2023")
      expect(@item_18.top_day).to eq("03/31/2023")
      expect(@item_17.top_day).to eq("04/06/2023")
    end
  end
end