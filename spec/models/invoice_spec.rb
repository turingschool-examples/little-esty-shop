require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'instance methods' do
    it '#date' do
      @merchant = create(:merchant)
      @customer_1 = create(:customer)
      @invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant, status: 0, created_at: "2012-01-25 09:54:09")

      expect(@invoice_1.date).to eq("Wednesday, Jan 25, 2012")
    end

    it '#total_revenue' do
      @merchant = create(:merchant)
      @customer_1 = create(:customer)
      @item = create(:item, merchant: @merchant)
      @invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant, status: 0, created_at: "2012-01-25 09:54:09")
      2.times do
        create(:invoice_item, item: @item, unit_price: 25, invoice: @invoice_1, status: 1)
      end


      expect(@invoice_1.total_revenue).to eq(50)
    end

    it '#customer_name' do
      @merchant = create(:merchant)
      @bob = create(:customer, first_name: "Cob", last_name: "Cornwall")
      @invoice_1 = create(:invoice, customer: @bob, merchant: @merchant)
      expect(@invoice_1.customer_name).to eq("Cob Cornwall")
    end
  end

  describe 'class methods' do
    it '::incomplete_invoices' do
      @merchant = create(:merchant)
      @customer_1 = create(:customer)

      @item_1 = create(:item, merchant: @merchant)
      @item_2 = create(:item, merchant: @merchant)

      @invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant, status: 0, created_at: "2012-01-25 09:54:09")
      @invoice_2 = create(:invoice, customer: @customer_1, merchant: @merchant, status: 1, created_at: "2012-02-25 09:54:09")
      @invoice_3 = create(:invoice, customer: @customer_1, merchant: @merchant, status: 2, created_at: "2012-03-25 09:54:09")
      @invoice_4 = create(:invoice, customer: @customer_1, merchant: @merchant, status: 2, created_at: "2012-04-25 09:54:09")
      @invoice_5 = create(:invoice, customer: @customer_1, merchant: @merchant, status: 0, created_at: "2012-04-25 09:54:09")

      @invoice_item_1 = create(:invoice_item, status: 0, item: @item_1, invoice: @invoice_1)
      @invoice_item_1 = create(:invoice_item, status: 0, item: @item_2, invoice: @invoice_1)

      @invoice_item_7 = create(:invoice_item, status: 0, item: @item_1, invoice: @invoice_5)
      @invoice_item_7 = create(:invoice_item, status: 0, item: @item_2, invoice: @invoice_5)

      @invoice_item_2 = create(:invoice_item, status: 0, item: @item_2, invoice: @invoice_2)
      @invoice_item_2 = create(:invoice_item, status: 2, item: @item_2, invoice: @invoice_2)

      @invoice_item_3 = create(:invoice_item, status: 1, item: @item_2, invoice: @invoice_3)
      @invoice_item_4 = create(:invoice_item, status: 2, item: @item_1, invoice: @invoice_3)

      @invoice_item_5 = create(:invoice_item, status: 2, item: @item_2, invoice: @invoice_4)
      @invoice_item_6 = create(:invoice_item, status: 2, item: @item_1, invoice: @invoice_4)

      expect(Invoice.incomplete_invoices).to eq([@invoice_1, @invoice_2, @invoice_5])
    end
  end

end
