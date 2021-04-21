require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :invoice_items}
    it {should have_many(:items).through :invoice_items}
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  before(:each) do
    @merchant_1 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_2.id)
    @invoice_3 = create(:invoice, customer_id: @customer_3.id)
    @invoice_4 = create(:invoice, customer_id: @customer_4.id)
    @invoice_5 = create(:invoice, customer_id: @customer_5.id)
    @invoice_6 = create(:invoice, customer_id: @customer_6.id)

    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @invoice_item_2 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_2.id)
    @invoice_item_3 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_3.id)
    @invoice_item_4 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_4.id)
    @invoice_item_5 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_5.id)
    @invoice_item_6 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_6.id)


    @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: 0)
    @transaction_2 = create(:transaction, invoice_id: @invoice_1.id, result: 0)
    @transaction_3 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_4 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_5 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_6 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_7 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_8 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_9 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_10 = create(:transaction, invoice_id: @invoice_1.id, result: 1)

    @transaction_11 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_12 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_13 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_14 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_15 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_16 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_17 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_18 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_19 = create(:transaction, invoice_id: @invoice_2.id, result: 1)

    @transaction_20 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_21 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_22 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_23 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_24 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_25 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_26 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_27 = create(:transaction, invoice_id: @invoice_3.id, result: 1)

    @transaction_28 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
    @transaction_29 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
    @transaction_30 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
    @transaction_31 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
    @transaction_32 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
    @transaction_33 = create(:transaction, invoice_id: @invoice_4.id, result: 1)

    @transaction_34 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
    @transaction_35 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
    @transaction_36 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
    @transaction_37 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
    @transaction_38 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
  end

  describe 'instance methods' do
    it "#formatted_date" do
      invoice_1 = create(:invoice, created_at: 'Mon, 19 Apr 2021 13:50:05 UTC +00:00')
      expect(invoice_1.formatted_date).to eq('Monday, April 19, 2021')
    end
  end

  describe 'class methods' do
    it '::incomplete_invoices' do
      invoice_1 = FactoryBot.create(:invoice)
      invoice_2 = FactoryBot.create(:invoice)
      invoice_3 = FactoryBot.create(:invoice)
      invoice_4 = FactoryBot.create(:invoice)
      invoice_5 = FactoryBot.create(:invoice)
      invoice_6 = FactoryBot.create(:invoice)

      expect(Invoice.incomplete_invoices.map(&:status).uniq).to match_array(["in progress", "cancelled"])
    end

    it '::distinct_invoices' do
      invoice_1 = FactoryBot.create(:invoice)
      invoice_2 = FactoryBot.create(:invoice)
      invoice_3 = FactoryBot.create(:invoice)
      invoice_4 = FactoryBot.create(:invoice)
      invoice_5 = FactoryBot.create(:invoice)
      invoice_6 = FactoryBot.create(:invoice)

      expected = [invoice_1, invoice_2, invoice_3, invoice_4, invoice_5, invoice_1]
    end

    it '::total_revenue' do
    end
  end
end
