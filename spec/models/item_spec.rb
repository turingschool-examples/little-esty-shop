require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:transactions).through(:invoices)}
  end
  
  describe "validations" do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:unit_price)}
    it { should validate_numericality_of(:unit_price)}
  end

  describe "Class methods" do
  end

  describe "Instance methods" do
    before (:each) do
      @customer_1 = create(:customer)
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, merchant_id: @merchant_1.id)
      @item_2 = create(:item, merchant_id: @merchant_1.id)
      @invoice_1 = create(:invoice, customer_id: @customer_1.id, created_at: '2011-01-08 20:54:10 UTC')
      @invoice_2 = create(:invoice, customer_id: @customer_1.id, created_at: '2012-05-11 13:54:10 UTC')
      @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id)
      @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_2.id)
      @invoice_item_3 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_1.id)
    end

    describe "#find_sold_price" do
      it "finds the price the item sold for in a particular invoice_item" do
        expect(@item_1.find_sold_price(@invoice_1)).to eq([@invoice_item_1.unit_price])
        expect(@item_2.find_sold_price(@invoice_1)).to eq([@invoice_item_2.unit_price])
        expect(@item_1.find_sold_price(@invoice_2)).to eq([@invoice_item_3.unit_price])
      end
    end

    describe "#quantity_sold" do
      it "finds the quantity of the item sold in a particular invoice_item" do
        expect(@item_1.quantity_sold(@invoice_1)).to eq([@invoice_item_1.quantity])
        expect(@item_2.quantity_sold(@invoice_1)).to eq([@invoice_item_2.quantity])
        expect(@item_1.quantity_sold(@invoice_2)).to eq([@invoice_item_3.quantity])
      end
    end

    describe "#invoice_item_status" do
      it "finds the status of the item in a particular invoice_item" do
        expect(@item_1.invoice_item_status(@invoice_1)).to eq([@invoice_item_1.status])
        expect(@item_2.invoice_item_status(@invoice_1)).to eq([@invoice_item_2.status])
        expect(@item_1.invoice_item_status(@invoice_2)).to eq([@invoice_item_3.status])
      end
    end

  end

end