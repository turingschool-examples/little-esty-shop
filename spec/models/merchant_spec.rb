require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    @merchant1 = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)

    @customer1 = create(:customer)
    @invoice1 = create(:invoice, customer_id: @customer1.id, status: 2, created_at: "2019-03-20 09:54:09 UTC")
    @invoice2 = create(:invoice, customer_id: @customer1.id, status: 2, created_at: "2011-04-25 09:54:09 UTC")
    @invoice3 = create(:invoice, customer_id: @customer1.id, status: 2, created_at: "2018-08-01 09:54:09 UTC")
    @invoice4 = create(:invoice, customer_id: @customer1.id, status: 0, created_at: "2020-07-01 09:54:09 UTC")

    @invoice_items1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, status: 1)
    @invoice_items2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice2.id, status: 1)
    @invoice_items4 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice4.id, status: 0)
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'class methods' do
  end


  describe 'instance methods' do
    describe '#invoice_items_ready_to_ship' do
      it 'returns items for the merchant that need to be shipped' do
        expect(@merchant1.invoice_items_ready_to_ship.to_a).to eq([@invoice_items2, @invoice_items1])
        expect(@merchant1.invoice_items_ready_to_ship.count).to eq(2)
        expect(@merchant1.invoice_items_ready_to_ship).not_to include(@invoice_item4)
      end

      it 'returns items from oldest to newest' do
        expect(@merchant1.invoice_items_ready_to_ship.first.invoice.format_time).to eq(@invoice2.format_time)
        expect(@merchant1.invoice_items_ready_to_ship.last.invoice.format_time).to eq(@invoice1.format_time)

      end
    end


  end
end
