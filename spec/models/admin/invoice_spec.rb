require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before(:each) do
    @merchant_1 = create(:merchant, name: "M1")
    @merchant_2 = create(:merchant, name: "M2")
    @merchant_3 = create(:merchant, name: "M3")
    @merchant_4 = create(:merchant, name: "M4")
    @merchant_5 = create(:merchant, name: "M5")

    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)
    @invoice_3 = create(:invoice)
    @invoice_4 = create(:invoice)
    @invoice_5 = create(:invoice)
    @invoice_6 = create(:invoice)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_2)
    @item_3 = create(:item, merchant: @merchant_3)
    @item_4 = create(:item, merchant: @merchant_4)
    @item_5 = create(:item, merchant: @merchant_5)

    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, status: "packaged", quantity: 1, unit_price: 30)
    @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, status: "pending", quantity: 100, unit_price: 3)
    @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id, status: "pending", quantity: 100, unit_price: 2)
    @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id, status: "packaged", quantity: 100, unit_price: 4)
    @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id, status: "packaged", quantity: 100, unit_price: 5)

  end

  describe 'instance methods' do
    describe '#total_revenue' do
      it 'shows the total revenue for an invoice' do

      expect(@invoice_1.total_revenue).to eq(30)
      expect(@invoice_2.total_revenue).to eq(300)
      expect(@invoice_3.total_revenue).to eq(200)
      end
    end
  end
end
