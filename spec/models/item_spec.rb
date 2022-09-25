require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should define_enum_for(:active_status).with_values([:disabled, :enabled]) }
    it { should validate_numericality_of(:unit_price) }
  end

  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:discounts).through(:merchant) }
  end

  before :each do
    @merchant_1 = create(:merchant)

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

    create(:invoice_items, invoice: @invoice_1, item: @item_10, unit_price: 1000, quantity: 10)
    create(:invoice_items, invoice: @invoice_1, item: @item_5, unit_price: 900, quantity: 9)
    create(:invoice_items, invoice: @invoice_1, item: @item_3, unit_price: 800, quantity: 8)
    create(:invoice_items, invoice: @invoice_2, item: @item_7, unit_price: 700, quantity: 7)
    create(:invoice_items, invoice: @invoice_2, item: @item_6, unit_price: 600, quantity: 6)
    create(:invoice_items, invoice: @invoice_3, item: @item_2, unit_price: 500, quantity: 5)
    create(:invoice_items, invoice: @invoice_3, item: @item_4, unit_price: 400, quantity: 4)
    create(:invoice_items, invoice: @invoice_4, item: @item_8, unit_price: 300, quantity: 3)
    create(:invoice_items, invoice: @invoice_4, item: @item_9, unit_price: 200, quantity: 2)
    create(:invoice_items, invoice: @invoice_4, item: @item_1, unit_price: 100, quantity: 1)

    create_list(:transaction, 5, invoice: @invoice_1, result: :success)
    create_list(:transaction, 5, invoice: @invoice_1, result: :failed)
    create_list(:transaction, 5, invoice: @invoice_2, result: :failed)
    create_list(:transaction, 5, invoice: @invoice_2, result: :success)
    create_list(:transaction, 5, invoice: @invoice_3, result: :failed)
    create_list(:transaction, 5, invoice: @invoice_3, result: :failed)
    create_list(:transaction, 5, invoice: @invoice_4, result: :success)
    create_list(:transaction, 5, invoice: @invoice_4, result: :success)
  end

  describe "Class Methods" do
    it "#active" do
      expect(Item.active).to eq([@item_1, @item_4, @item_5, @item_7, @item_9])
    end

    it "#inactive" do
      expect(Item.inactive).to eq([@item_2, @item_3, @item_6, @item_8, @item_10])
    end

    it '#top_5_order_by_revenue' do
      expect(Item.top_5_order_by_revenue).to eq([@item_10, @item_5, @item_3, @item_7, @item_6])
    end

    it '#total_revenue_of_all_items' do
      expect(Item.total_revenue_of_all_items).to eq(179000)
    end
  end

  describe 'instance methods' do
    before :each do
      @item_1 = create(:item)
      @item_2 = create(:item)

      @invoice_1 = create(:invoice)

      @invoice_item_1 = create(:invoice_items, invoice_id: @invoice_1.id, item_id: @item_1.id)
      @invoice_item_2 = create(:invoice_items, invoice_id: @invoice_1.id, item_id: @item_2.id)
    end

    it "#quantity_purchased" do
      expect(@item_1.quantity_purchased(@invoice_1.id)).to eq(@invoice_item_1.quantity)
      expect(@item_2.quantity_purchased(@invoice_1.id)).to eq(@invoice_item_2.quantity)
    end

    it "#price_sold" do
      expect(@item_1.price_sold(@invoice_1.id)).to eq(@invoice_item_1.unit_price)
      expect(@item_2.price_sold(@invoice_1.id)).to eq(@invoice_item_2.unit_price)
    end

    it "#shipping_status" do
      expect(@item_1.shipping_status(@invoice_1.id)).to eq(@invoice_item_1.status)
      expect(@item_2.shipping_status(@invoice_1.id)).to eq(@invoice_item_2.status)
    end

    it "#item-revenue" do
      expect(@item_10.revenue).to eq(50000)
    end
  end
end
