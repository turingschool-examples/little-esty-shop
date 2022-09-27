require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should define_enum_for(:status).with_values(["in progress", :completed, :cancelled]) }
  end

  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:bulk_discounts).through(:merchants) }
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

    describe '#best_day' do
      it "Return invoice date with most number of sales" do
        expect(Invoice.best_day.created_at).to eq(@invoice_8.created_at)
      end

      it 'If duplicate dates, returns most recent date' do
        # expectation here
      end

      it 'Only returns invoices with status: completed' do
        # expectation here
      end
    end
  end

  describe "instance methods" do 
    it "#total_revenue_of_invoice" do
      expect(@invoice_1.total_revenue_of_invoice).to be (50000)
    end

    describe 'total_revenue_merchant' do
      it 'shows total invoice revenue for merchant' do
        merchant_1 = create(:merchant)

        invoice_1 = create(:invoice)

        item_1 = create(:item, merchant: merchant_1)
        item_2 = create(:item, merchant: merchant_1)
        item_3 = create(:item, merchant: merchant_1)

        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_1.id, unit_price: 100, quantity: 10) # 1000
        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_2.id, unit_price: 200, quantity: 20) # 4000
        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_3.id, unit_price: 150, quantity: 5) # 750

        expect(invoice_1.total_revenue_merchant(merchant_1)).to eq(5750)
      end

      it 'show total invoice revenue with multiple merchants' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)

        item_1 = create(:item, merchant: merchant_1)
        item_2 = create(:item, merchant: merchant_1)
        item_3 = create(:item, merchant: merchant_1)

        item_4 = create(:item, merchant: merchant_2)
        item_5 = create(:item, merchant: merchant_2)
        item_6 = create(:item, merchant: merchant_2)

        invoice_1 = create(:invoice)

        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_1.id, unit_price: 100, quantity: 10) # 1000
        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_2.id, unit_price: 200, quantity: 20) # 4000
        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_3.id, unit_price: 150, quantity: 5) # 750

        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_4.id, unit_price: 50, quantity: 5) # 250
        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_5.id, unit_price: 75, quantity: 15) # 1125
        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_6.id, unit_price: 15, quantity: 10) # 150

        expect(invoice_1.total_revenue_merchant(merchant_1)).to eq(5750)
        expect(invoice_1.total_revenue_merchant(merchant_2)).to eq(1525)
      end
    end

    describe 'discount_amount_merchant' do
      it 'shows the amount of discount by merchant' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)

        item_1 = create(:item, merchant: merchant_1)
        item_2 = create(:item, merchant: merchant_1)
        item_3 = create(:item, merchant: merchant_1)

        item_4 = create(:item, merchant: merchant_2)
        item_5 = create(:item, merchant: merchant_2)
        item_6 = create(:item, merchant: merchant_2)

        invoice_1 = create(:invoice)

        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_1.id, unit_price: 100, quantity: 10) # 1000
        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_2.id, unit_price: 200, quantity: 20) # 4000
        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_3.id, unit_price: 150, quantity: 5) # 750

        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_4.id, unit_price: 50, quantity: 5) # 250
        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_5.id, unit_price: 75, quantity: 15) # 1125
        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_6.id, unit_price: 15, quantity: 10) # 150

        bulk_discount_merch_1 = create(:bulk_discount, merchant: merchant_1, discount: 0.25, threshold: 10)
        bulk_discount_merch_2 = create(:bulk_discount, merchant: merchant_2, discount: 0.10, threshold: 10)

        expect(invoice_1.discount_amount_merchant(merchant_1)).to eq(1250)
        expect(invoice_1.discount_amount_merchant(merchant_2)).to eq(127.5)
      end

      it 'selects hightest bulk discount percentage' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)

        item_1 = create(:item, merchant: merchant_1)
        item_2 = create(:item, merchant: merchant_1)
        item_3 = create(:item, merchant: merchant_1)

        item_4 = create(:item, merchant: merchant_2)
        item_5 = create(:item, merchant: merchant_2)
        item_6 = create(:item, merchant: merchant_2)

        invoice_1 = create(:invoice)

        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_1.id, unit_price: 100, quantity: 10) # 1000
        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_2.id, unit_price: 200, quantity: 20) # 4000
        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_3.id, unit_price: 150, quantity: 5) # 750

        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_4.id, unit_price: 50, quantity: 5) # 250
        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_5.id, unit_price: 75, quantity: 15) # 1125
        create(:invoice_items, invoice_id: invoice_1.id, item_id: item_6.id, unit_price: 15, quantity: 10) # 150

        bulk_discount_1_merch_1 = create(:bulk_discount, merchant: merchant_1, discount: 0.25, threshold: 10)
        bulk_discount_2_merch_1 = create(:bulk_discount, merchant: merchant_1, discount: 0.50, threshold: 10)

        bulk_discount_1_merch_2 = create(:bulk_discount, merchant: merchant_2, discount: 0.10, threshold: 10)
        bulk_discount_2_merch_2 = create(:bulk_discount, merchant: merchant_2, discount: 0.50, threshold: 10)
        
        expect(invoice_1.discount_amount_merchant(merchant_1)).to eq(2500)
        expect(invoice_1.discount_amount_merchant(merchant_2)).to eq(637.5)
      end
    end
  end
end
