require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe "instance methods" do
    it "#disable_item" do
      @merchant1 = create(:merchant)

      @item = create(:item, merchant_id: @merchant1.id)
      @item.disable_item
      expect(@item.status).to be false
    end

    it "#enable_item" do
      @merchant1 = create(:merchant)

      @item = create(:item, merchant_id: @merchant1.id, status: false)
      @item.enable_item
      expect(@item.status).to be true
    end

    it "#top_selling_date - by total sales" do
      @merchant1 = create(:merchant)
      @item1 = create(:item, merchant_id: @merchant1.id)

      @invoice1 = create(:invoice, created_at: "2015-07-12 09:54:09 UTC")
      @invoice2 = create(:invoice, created_at: "2019-05-12 09:54:09 UTC")
      @invoice3 = create(:invoice, created_at: "2019-05-12 09:54:09 UTC")
      @invoice4 = create(:invoice, created_at: "2011-12-10 09:54:09 UTC")
      @invoice5 = create(:invoice, created_at: "2018-06-04 09:54:09 UTC")      # @invoice1 = create(:invoice, created_at: "2013-03-25 09:54:09 UTC")      # @invoice2 = create(:invoice, created_at: "2012-03-17 09:54:09 UTC")      # @invoice3 = create(:invoice, created_at: "2011-03-01 09:54:09 UTC")      # @invoice4 = create(:invoice, created_at: "2020-02-20 09:54:09 UTC")      # @invoice5 = create(:invoice, created_at: "2019-05-12 09:54:09 UTC")

      @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, status: 2, quantity: 6, unit_price: 100)
      @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item1.id, status: 2, quantity: 5, unit_price: 100)
      @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item1.id, status: 2, quantity: 4, unit_price: 100)
      @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, item_id: @item1.id, status: 2, quantity: 3, unit_price: 100)
      @invoice_item5 = create(:invoice_item, invoice_id: @invoice5.id, item_id: @item1.id, status: 2, quantity: 2, unit_price: 100)

      expect(@item1.top_selling_date).to eq("Sunday, May 12, 2019")
    end
  end
end
