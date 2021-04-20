require 'rails_helper'

RSpec.describe Merchant, type: :model do
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

  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through :items }
    it { should have_many(:invoices).through :invoice_items }
    it { should have_many(:customers).through :invoices }
    it { should have_many(:transactions).through :invoices }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'instance methods' do
    it '#top_five_customers_by_successful_transaction_count' do
      expect(@merchant_1.top_five_customers_by_successful_transaction_count.to_a).to eq([@customer_2, @customer_1, @customer_3, @customer_4, @customer_5])
    end

    it '#invoice_items_not_shipped_by_invoice_date' do ##Update name when method is created
      merchant_2 = create(:merchant)

      item_2 = create(:item, merchant: merchant_2)
      item_3 = create(:item, merchant: merchant_2)
      item_4 = create(:item, merchant: merchant_2)
      item_5 = create(:item, merchant: merchant_2)
      item_6 = create(:item, merchant: merchant_2)
      item_7 = create(:item, merchant: merchant_2)

      customer_7 = create(:customer)

      invoice_7 = create(:invoice, customer_id: customer_7.id, created_at: "Sun, 18 Apr 2021 21:37:10 UTC +00:00")
      invoice_8 = create(:invoice, customer_id: customer_7.id, created_at: "Sun, 4 Apr 2021 21:37:10 UTC +00:00")
      invoice_9 = create(:invoice, customer_id: customer_7.id, created_at: "Sun, 11 Apr 2021 21:37:10 UTC +00:00")
      invoice_10 = create(:invoice, customer_id: customer_7.id, created_at: "Mon, 5 Apr 2021 21:37:10 UTC +00:00")
      invoice_11 = create(:invoice, customer_id: customer_7.id, created_at: "Mon, 12 Apr 2021 21:37:10 UTC +00:00")
      invoice_12 = create(:invoice, customer_id: customer_7.id, created_at: "Mon, 19 Apr 2021 21:37:10 UTC +00:00")

      invoice_item_7 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_7.id, status: 0)
      invoice_item_8 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_8.id, status: 0)
      invoice_item_9 = create(:invoice_item, item_id: item_4.id, invoice_id: invoice_9.id, status: 0)
      invoice_item_10 = create(:invoice_item, item_id: item_5.id, invoice_id: invoice_10.id, status: 0)
      invoice_item_11 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_11.id, status: 0)
      invoice_item_12 = create(:invoice_item, item_id: item_7.id, invoice_id: invoice_12.id, status: 0)

      expect(merchant_2.invoice_items_not_shipped_by_invoice_date[0].formatted_date).to eq(invoice_8.formatted_date)
      expect(merchant_2.invoice_items_not_shipped_by_invoice_date[1].formatted_date).to eq(invoice_10.formatted_date)
      expect(merchant_2.invoice_items_not_shipped_by_invoice_date[2].formatted_date).to eq(invoice_9.formatted_date)
      expect(merchant_2.invoice_items_not_shipped_by_invoice_date[3].formatted_date).to eq(invoice_11.formatted_date)
      expect(merchant_2.invoice_items_not_shipped_by_invoice_date[4].formatted_date).to eq(invoice_7.formatted_date)
      expect(merchant_2.invoice_items_not_shipped_by_invoice_date[5].formatted_date).to eq(invoice_12.formatted_date)

      # add test for item names
    end
  end
end
