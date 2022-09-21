require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)
    @customer_7 = create(:customer)
    @customer_8 = create(:customer)

    @invoice_1 = create(:invoice, status: :completed, created_at: "08-10-2022", customer: @customer_1)
    @invoice_3 = create(:invoice, status: :cancelled, created_at: "10-08-2022", customer: @customer_3)
    @invoice_4 = create(:invoice, status: :completed, created_at: "10-08-2022", customer: @customer_4)
    @invoice_2 = create(:invoice, status: :cancelled, created_at: "08-10-2022", customer: @customer_2)
    @invoice_5 = create(:invoice, status: :completed, created_at: "10-08-2022", customer: @customer_5)
    @invoice_6 = create(:invoice, status: :completed, created_at: "01-07-2022", customer: @customer_6)
    @invoice_7 = create(:invoice, status: :completed, created_at: "01-07-2022", customer: @customer_7)
    @invoice_8 = create(:invoice, status: :completed, created_at: "01-07-2022", customer: @customer_8)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_2)
    @item_3 = create(:item, merchant: @merchant_3)

    @invoice_item1 = create(:invoice_items, item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 2000, status: :packaged)
    @invoice_item2 = create(:invoice_items, item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 1000, status: :pending)
    @invoice_item3 = create(:invoice_items, item_id: @item_2.id, invoice_id: @invoice_3.id, quantity: 4, unit_price: 1000, status: :shipped)
    @invoice_item4 = create(:invoice_items, item_id: @item_3.id, invoice_id: @invoice_4.id, quantity: 2, unit_price: 2500, status: :pending)
    @invoice_item5 = create(:invoice_items, item_id: @item_3.id, invoice_id: @invoice_5.id, quantity: 3, unit_price: 2500, status: :shipped)
    @invoice_item6 = create(:invoice_items, item_id: @item_3.id, invoice_id: @invoice_5.id, quantity: 3, unit_price: 2500, status: :packaged)

    @transactions_1 = create_list(:transaction, 3, result: :failed, invoice: @invoice_1)
    @transactions_2 = create_list(:transaction, 5, result: :success, invoice: @invoice_1)

    @transactions_3 = create_list(:transaction, 1, result: :failed, invoice: @invoice_2)
    @transactions_4 = create_list(:transaction, 7, result: :success, invoice: @invoice_2)
  end

  describe "class methods" do

    it '#unshipped_invoices' do
      expect(Invoice.unshipped_invoices).to include(@invoice_1, @invoice_2, @invoice_4, @invoice_5)
    end

    it '#successful_transactions_count' do
      expect(Invoice.successful_transactions_count).to eq(12)
    end

    it "#sort_by_date" do
      expect(Invoice.sort_by_date).to eq([@invoice_8, @invoice_7, @invoice_6, @invoice_5, @invoice_3, @invoice_4, @invoice_1, @invoice_2])
    end

    it "#best_day" do
      expect(Invoice.best_day.created_at).to eq(@invoice_8.created_at)
    end
  end

  describe "class methods" do 
    it "#total_revenue_of_invoice" do
      expect(@invoice_1.total_revenue_of_invoice).to be (50000)
    end
  end
end
