require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end


  describe 'class methods' do
    before :each do
      @merchant1 = create(:merchant, status: true)
      @merchant2 = create(:merchant, status: true)
      @merchant3 = create(:merchant, status: false)
      @merchant4 = create(:merchant, status: false)
      @merchant5 = create(:merchant, status: false)
      @merchant6 = create(:merchant, status: true)

      @item1 = create(:item, merchant_id: @merchant1.id)
      @item2 = create(:item, merchant_id: @merchant2.id)
      @item3 = create(:item, merchant_id: @merchant3.id)
      @item4 = create(:item, merchant_id: @merchant4.id)
      @item5 = create(:item, merchant_id: @merchant5.id)
      @item6 = create(:item, merchant_id: @merchant6.id)

      @invoice1 = create(:invoice)
      @invoice2 = create(:invoice)
      @invoice3 = create(:invoice)
      @invoice4 = create(:invoice)
      @invoice5 = create(:invoice)
      @invoice6 = create(:invoice)

      @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, status: 1, quantity: 5, unit_price: 100)
      @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item2.id, status: 1, quantity: 15, unit_price: 100)
      @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item3.id, status: 0, quantity: 9, unit_price: 100)
      @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, item_id: @item4.id, status: 2, quantity: 10, unit_price: 100)
      @invoice_item5 = create(:invoice_item, invoice_id: @invoice5.id, item_id: @item5.id, status: 0, quantity: 2, unit_price: 100)
      @invoice_item6 = create(:invoice_item, invoice_id: @invoice6.id, item_id: @item6.id, status: 2, quantity: 11, unit_price: 100)

      @transactions = create_list(:transaction, 6, invoice_id: @invoice_item1.invoice.id, result: 0)
      @transactions2 = create_list(:transaction, 7, invoice_id: @invoice_item2.invoice.id, result: 0)
      @transactions3 = create_list(:transaction, 8, invoice_id: @invoice_item3.invoice.id, result: 0)
      @transactions4 = create_list(:transaction, 9, invoice_id: @invoice_item4.invoice.id, result: 0)
      @transactions5 = create_list(:transaction, 10, invoice_id: @invoice_item5.invoice.id, result: 0)
      @transactions6 = create_list(:transaction, 11, invoice_id: @invoice_item6.invoice.id, result: 1)
    end

    describe "::enable" do
      it "groups merchants by enabled merchs" do
        expect(Merchant.enable).to eq([@merchant1, @merchant2, @merchant6])
      end
    end

    describe "::disable" do
      it "groups mercahnts by merchs disabled" do
        expect(Merchant.disable).to eq([@merchant3, @merchant4, @merchant5])
      end
    end

    describe "::top_merchants" do
      it "Shows the top  merchants by revenue orderd high to low" do

        expect(Merchant.top_merchants.first.name).to eq(@merchant2.name)
        expect(Merchant.top_merchants.second.name).to eq(@merchant4.name)
        expect(Merchant.top_merchants.third.name).to eq(@merchant3.name)
        expect(Merchant.top_merchants.fourth.name).to eq(@merchant1.name)
        expect(Merchant.top_merchants.fifth.name).to eq(@merchant5.name)
        expect(Merchant.top_merchants).not_to include(@merchant6)
      end
    end


    describe 'instance methods' do
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
end
