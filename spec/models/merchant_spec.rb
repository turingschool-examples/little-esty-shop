require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many(:items)}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
  end

  before(:each) do
    @merchant_1 = create(:merchant, status: "enabled")
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant, status: "disabled")

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_2)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_2)
    @item_5 = create(:item, merchant: @merchant_2)
    @item_6 = create(:item, merchant: @merchant_2)
    @item_7 = create(:item, merchant: @merchant_3)
    @item_8 = create(:item, merchant: @merchant_3)
    @item_9 = create(:item, merchant: @merchant_3)
    @item_10 = create(:item, merchant: @merchant_3)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)

    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_1.items << @item_1
    @invoice_2 = create(:invoice, customer: @customer_1)
    @invoice_2.items << @item_2
    @invoice_3 = create(:invoice, customer: @customer_1)
    @invoice_3.items << @item_3
    @invoice_3.items << @item_4
    @invoice_4 = create(:invoice, customer: @customer_2)
    @invoice_4.items << @item_5
    @invoice_4.items << @item_7
  end

  describe 'merchant invoices' do
    it 'returns merchant invoice ids' do
      expect(@merchant_2.all_invoice_ids).to eq([@invoice_2.id, @invoice_3.id, @invoice_4.id])
    end
  end

  describe '#toggle_status' do
    it 'changes merchant status to disabled if currently enabled and the inverse' do
      expect(@merchant_1.status).to eq("enabled")

      @merchant_1.toggle_status

      expect(@merchant_1.status).to eq("disabled")

      @merchant_1.toggle_status

      expect(@merchant_1.status).to eq("enabled")
    end
  end

  describe '#group_by_status' do
    it 'returns merchants based on status argument' do
      enabled_expected_1 = @merchant_1
      enabled_expected_2 = @merchant_2
      enabled_expected_3 = @merchant_3
      disabled_expected_1 = @merchant_4

      expect(Merchant.group_by_status("enabled")).to include(enabled_expected_1)
      expect(Merchant.group_by_status("enabled")).to include(enabled_expected_2)
      expect(Merchant.group_by_status("enabled")).to include(enabled_expected_3)
      expect(Merchant.group_by_status("disabled")).to include(disabled_expected_1)
    end
  end
end