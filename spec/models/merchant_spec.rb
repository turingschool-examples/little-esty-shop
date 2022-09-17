require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do

    it {should have_many(:items)}

    describe 'instance variables' do

      before(:each) do
        @merchant_1 = create(:merchant)
        @item_1 = create(:item, merchant: @merchant_1)
        @item_2 = create(:item, merchant: @merchant_1)

        @merchant_2 = create(:merchant)
        @item_3 = create(:item, merchant: @merchant_2)
        @item_4 = create(:item, merchant: @merchant_2)

        @invoice_1 = create(:invoice)
        @invoice_2 = create(:invoice)
        @invoice_3 = create(:invoice)
        @invoice_4 = create(:invoice)

        @invoice_1.items << [@item_1, @item_2, @item_3]
        @invoice_2.items << [@item_3, @item_4]
        @invoice_3.items << [@item_1, @item_4]
        @invoice_4.items << @item_2
      end

      describe '.invoices' do
        it 'returns a list of invoices which contain an item from the merchant' do
          expect(@merchant_1.distinct_invoices).to match_array([@invoice_1, @invoice_3, @invoice_4])
          expect(@merchant_2.distinct_invoices).to match_array([@invoice_1, @invoice_2, @invoice_3])
        end
      end

      describe 'top 5 customers' do
        customer_1 = create(:customer)
        customer_2 = create(:customer)
        customer_3 = create(:customer)
        customer_4 = create(:customer)
        customer_5 = create(:customer)
        customer_6 = create(:customer)
        customer_7 = create(:customer)
        customer_8 = create(:customer)

        invoice_1 = create(:invoice, customer: customer_1)
        invoice_2 = create(:invoice, customer: customer_2)
        invoice_3 = create(:invoice, custoemr: customer_3)
        invoice_4 = create(:invoice, customer: customer_4)
        invoice_5 = create(:invoice, customer: customer_5)
        invoice_6 = create(:invoice, customer: customer_6)
        invoice_7 = create(:invoice, customer: customer_7)
        invoice_8 = create(:invoice, customer: customer_8)
        invoice_9 = create(:invoice, customer: customer_5)
        invoice_10 = create(:invoice, customer: customer_6)
        invoice_11 = create(:invoice, customer: customer_4)

        merchant = create(:merchant)

        item_1 = create(:item, merchant: merchant)
        item_2 = create(:item, merchant: merchant)
        item_3 = create(:item, merchant: merchant)
        item_4 = create(:item, merchant: merchant)

      end
    end

  end
end
