require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  before :each do
    @merchant1 = create(:merchant)
    @item1 = create(:item, merchant_id: @merchant1.id)
    @customer1 = create(:customer)
    @invoice1 = create(:invoice, customer_id: @customer1.id)
    @invoice_items1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, quantity: 4, unit_price: 1200)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @invoice2 = create(:invoice, customer_id: @customer1.id)
    @invoice_items2 = create(:invoice_item, item_id: @item2.id,invoice_id: @invoice1.id, quantity: 2, unit_price: 73000)
  end

  describe 'Model methods' do
    it 'can calculate total revenue for invoice_item' do
      expect(InvoiceItem.total_revenue).to eq(150800)
    end
  end
end
