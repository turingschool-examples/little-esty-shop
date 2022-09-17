require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
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
  end
end