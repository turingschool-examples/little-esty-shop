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
  end

  describe "class methods" do
    before do
      test_data
    end

    it "top_five_items" do
      expect(@merchant_3.items.top_five_items.all).to eq([@item_21, @item_20, @item_19, @item_18, @item_17,])
    end

    it "top_day" do
      @invoice_10.update(created_at: "04/06/2023")
      @invoice_item_50.update(quantity: 10)
      @invoice_7.update(created_at: "04/12/2023")
      @invoice_item_47.update(quantity: 10)
      @invoice_4.update(created_at: "04/09/2023")
      @invoice_item_44.update(quantity: 10)
      @invoice_1.update(created_at: "04/11/2023")
      @invoice_item_41.update(quantity: 10)
      @invoice_20.update(created_at: "04/06/2023")
      @invoice_item_40.update(quantity: 10)
      
      expect(@item_21.top_day).to eq("04/06/2023")
      expect(@item_20.top_day).to eq("04/12/2023")
      expect(@item_19.top_day).to eq("04/09/2023")
      expect(@item_18.top_day).to eq("04/11/2023")
      expect(@item_17.top_day).to eq("04/06/2023")
    end
  end
end