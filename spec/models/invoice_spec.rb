require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationship' do
    it {should belong_to :customer}
    it {should have_many :transactions}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe '.incomplete' do
    it 'returns an array of incomplete invoices' do
      @customer = create(:customer)
      @invoice1 = create(:invoice, customer_id: @customer.id)
      @invoice2 = create(:invoice, customer_id: @customer.id)
      @invoice3 = create(:invoice, customer_id: @customer.id)
      @invoice4 = create(:invoice, customer_id: @customer.id)
      @invoice5 = create(:invoice, customer_id: @customer.id)
      @merchant = create(:merchant)
      @item = create(:item, merchant_id: @merchant.id)
      #StatusKey: 0 => packaged, 1 => pending, 2 => shipped
      @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item.id, status: 2)
      @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item.id, status: 0)
      @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item.id, status: 2)
      @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, item_id: @item.id, status: 0)
      @invoice_item5 = create(:invoice_item, invoice_id: @invoice5.id, item_id: @item.id, status: 1)
      expect(Invoice.incomplete.sort).to eq([@invoice2, @invoice4, @invoice5]) 
    end
  end
end
