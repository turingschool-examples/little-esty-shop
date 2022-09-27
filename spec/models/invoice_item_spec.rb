require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should define_enum_for(:status).with_values([:pending, :packaged, :shipped]) }
    it { should validate_numericality_of(:quantity) }
    it { should validate_numericality_of(:unit_price) }
  end
  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
    it { should have_many(:discounts).through(:item) }
  end

  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @item_1 = create(:item, name: "item_1", merchant: @merchant_1, active_status: :enabled)
    @item_2 = create(:item, name: "item_2", merchant: @merchant_1)
    @item_3 = create(:item, name: "item_3", merchant: @merchant_1)
    @item_4 = create(:item, name: "item_4", merchant: @merchant_1, active_status: :enabled)
    @item_5 = create(:item, name: "item_5", merchant: @merchant_1, active_status: :enabled)
    @item_6 = create(:item, name: "item_6", merchant: @merchant_1)
    @item_7 = create(:item, name: "item_7", merchant: @merchant_1, active_status: :enabled)
    @item_8 = create(:item, name: "item_8", merchant: @merchant_1)
    @item_9 = create(:item, name: "item_9", merchant: @merchant_1, active_status: :enabled)
    @item_10 = create(:item, name: "item_10", merchant: @merchant_1)

    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)
    @invoice_3 = create(:invoice)
    @invoice_4 = create(:invoice)

    @item_invoice_1 = create(:invoice_items, invoice: @invoice_1, item: @item_10, unit_price: 1000, quantity: 10)
    @item_invoice_2 = create(:invoice_items, invoice: @invoice_1, item: @item_5, unit_price: 900, quantity: 25)
    @item_invoice_3 = create(:invoice_items, invoice: @invoice_1, item: @item_3, unit_price: 800, quantity: 8)
    @item_invoice_4 = create(:invoice_items, invoice: @invoice_2, item: @item_7, unit_price: 700, quantity: 7)
    @item_invoice_5 = create(:invoice_items, invoice: @invoice_2, item: @item_6, unit_price: 600, quantity: 6)
    @item_invoice_6 = create(:invoice_items, invoice: @invoice_3, item: @item_2, unit_price: 500, quantity: 5)
    @item_invoice_7 = create(:invoice_items, invoice: @invoice_3, item: @item_4, unit_price: 400, quantity: 4)
    @item_invoice_8 = create(:invoice_items, invoice: @invoice_4, item: @item_8, unit_price: 300, quantity: 3)
    @item_invoice_9 = create(:invoice_items, invoice: @invoice_4, item: @item_9, unit_price: 200, quantity: 2)
    @item_invoice_10 = create(:invoice_items, invoice: @invoice_4, item: @item_1, unit_price: 100, quantity: 1)

    @discount_1 = create(:discount, bulk_discount: 0.10, item_threshold: 8, merchant: @merchant_1)
    @discount_2 = create(:discount, bulk_discount: 0.25, item_threshold: 20, merchant: @merchant_1)
  end

  describe 'instance methods' do
    describe 'it finds if an item has a bulk discount' do
      it '#discounts_applied' do

        expect(@item_invoice_1.discounts_applied).to eq(@discount_1)
        expect(@item_invoice_2.discounts_applied).to eq(@discount_2)
        expect(@item_invoice_5.discounts_applied).to eq(nil)

      end
    end

    describe 'it calculates discounted unit_price' do
      it '#discount_price' do

        expect(@item_invoice_1.discount_price).to eq(9000)
        expect(@item_invoice_2.discount_price).to eq(16875)
        expect(@item_invoice_3.discount_price).to eq(5760)
      end
    end
  end
end
