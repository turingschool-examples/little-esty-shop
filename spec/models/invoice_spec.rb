# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationship' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe '.incomplete' do
    before do
      @customer = create(:customer)
      @invoice1 = create(:invoice, customer_id: @customer.id)
      @invoice2 = create(:invoice, customer_id: @customer.id, created_at: Time.new(1999))
      @invoice3 = create(:invoice, customer_id: @customer.id)
      @invoice4 = create(:invoice, customer_id: @customer.id, created_at: Time.new(2022))
      @invoice5 = create(:invoice, customer_id: @customer.id, created_at: Time.new(2002))
      @merchant = create(:merchant)
      @item = create(:item, merchant_id: @merchant.id)
      # StatusKey: 0 => packaged, 1 => pending, 2 => shipped
      @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item.id, status: 2)
      @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item.id, status: 0)
      @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item.id, status: 2)
      @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, item_id: @item.id, status: 0)
      @invoice_item5 = create(:invoice_item, invoice_id: @invoice5.id, item_id: @item.id, status: 1)
    end
    it 'returns an array of incomplete invoices' do
      expect(Invoice.incomplete).to contain_exactly(@invoice2, @invoice4, @invoice5)
    end

    it 'is ordered by date created at' do
      expect(Invoice.incomplete).to eq([@invoice2, @invoice5, @invoice4])
    end

    it 'lists its items with relational atrributes' do
      expect(@invoice1.items_with_invoice_attributes.first.name). to eq(@item.name)
      expect(@invoice1.items_with_invoice_attributes.first.quantity). to eq(@invoice_item1.quantity)
      expect(@invoice1.items_with_invoice_attributes.first.unit_price). to eq(@invoice_item1.unit_price)
      expect(@invoice1.items_with_invoice_attributes.first.status). to eq(@invoice_item1.status)
    end
  end
end
