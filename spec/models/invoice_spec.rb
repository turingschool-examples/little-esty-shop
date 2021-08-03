require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :transactions}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many :transactions}
    it {should have_many(:merchants).through(:items)}
  end

  describe 'validations' do
    it { should define_enum_for(:status).with([:cancelled, "in progress", :completed]) }
  end

  before(:each) do
    @customer1 = create(:customer)
    @customer2 = create(:customer)

    @invoice1 = create(:invoice, customer_id: @customer1.id)
    @invoice2 = create(:invoice, customer_id: @customer1.id)
    @invoice3 = create(:invoice, customer_id: @customer1.id)
    @invoice4 = create(:invoice, customer_id: @customer2.id)
    @invoice5 = create(:invoice, customer_id: @customer2.id)
    @invoice6 = create(:invoice, customer_id: @customer2.id)
    @invoice7 = create(:invoice, customer_id: @customer2.id)


    @merchant = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant.id)
    @item2 = create(:item, merchant_id: @merchant.id)
    @item3 = create(:item, merchant_id: @merchant.id)
    @item4 = create(:item, merchant_id: @merchant.id)

    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, status: 0)
    @invoice_item2 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice2.id, status: 0)
    @invoice_item3 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice3.id, status: 1)
    @invoice_item4 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice4.id, status: 1)
    @invoice_item5 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice5.id, status: 2)
    @invoice_item6 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice6.id, status: 0)
    @invoice_item6 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice7.id, status: 2, quantity: 5, unit_price: 10)
    @invoice_item6 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice7.id, status: 2, quantity: 5, unit_price: 10)


  end

  describe 'class methods' do
    it '#incomplete_invoices' do

      expect(Invoice.incomplete_invoices).to eq([@invoice1, @invoice2, @invoice3, @invoice4, @invoice6])
    end
  end

  describe 'instance methods' do
    it '::total_revenue' do

      expect(@invoice7.total_revenue).to eq(100)
    end
  end
end
