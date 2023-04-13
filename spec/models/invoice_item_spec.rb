require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  
  describe 'relationships' do
    it { should belong_to :invoice}
    it { should belong_to :item}
  end

  describe 'class methods' do
    before(:each) do
      test_data

      @invoice_21 = Invoice.create!(customer_id: @customer_1.id, status: 1)
      @invoice_22 = Invoice.create!(customer_id: @customer_2.id, status: 1)
      @invoice_item_21 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_21.id, quantity: 1, unit_price: 100, status: 2)
      @invoice_item_22 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_22.id, quantity: 1, unit_price: 100, status: 2)

    end
    it '::not_yet_shipped' do 
      expect(@merchant_1.invoice_items.not_yet_shipped.count).to eq(20)

      @invoice_23 = Invoice.create!(customer_id: @customer_3.id, status: 1)
      @invoice_24 = Invoice.create!(customer_id: @customer_4.id, status: 1)
      @invoice_item_23 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_23.id, quantity: 1, unit_price: 100, status: 0)
      @invoice_item_24 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_24.id, quantity: 1, unit_price: 100, status: 0)

      expect(@merchant_1.invoice_items.not_yet_shipped.count).to eq(22)
    end
  end
end

