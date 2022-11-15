require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "Relationships" do
    it { should have_many(:invoices) }
  end

  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @merchant_1_item_1 = create(:item, merchant: @merchant_1)
    @merchant_1_item_not_ordered = create(:item, merchant: @merchant_1)

    @merchant_2_item_1 = create(:item, merchant: @merchant_2)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @customer_1_invoice_1 = create(:invoice, customer: @customer_1, status: 1)
    @customer_1_invoice_2 = create(:invoice, customer: @customer_1, status: 1)

    @customer_2_invoice_1 = create(:invoice, customer: @customer_2, status: 1)
    @customer_3_invoice_1 = create(:invoice, customer: @customer_3, status: 1)
    @customer_4_invoice_1 = create(:invoice, customer: @customer_4, status: 1)
    @customer_5_invoice_1 = create(:invoice, customer: @customer_5, status: 1)

    @customer_6_invoice_1 = create(:invoice, customer: @customer_6, status: 1)
    @customer_6_invoice_2 = create(:invoice, customer: @customer_6, status: 0)

    create(:invoice_item, invoice: @customer_1_invoice_1, item: @merchant_1_item_1, status: 2)
    create(:invoice_item, invoice: @customer_1_invoice_2, item: @merchant_2_item_1, status: 0)

    create(:invoice_item, invoice: @customer_2_invoice_1, item: @merchant_1_item_1, status: 2)
    create(:invoice_item, invoice: @customer_3_invoice_1, item: @merchant_1_item_1, status: 2)
    create(:invoice_item, invoice: @customer_4_invoice_1, item: @merchant_1_item_1, status: 2)
    create(:invoice_item, invoice: @customer_5_invoice_1, item: @merchant_1_item_1, status: 2)

    create(:invoice_item, invoice: @customer_6_invoice_1, item: @merchant_1_item_1, status: 0)
    create(:invoice_item, invoice: @customer_6_invoice_2, item: @merchant_1_item_1, status: 1)

    3.times { create(:transaction, invoice: @customer_1_invoice_1, result: 'success') }
              create(:transaction, invoice: @customer_1_invoice_2, result: 'success')

    2.times { create(:transaction, invoice: @customer_2_invoice_1, result: 'success') }

    2.times { create(:transaction, invoice: @customer_3_invoice_1, result: 'success') }

    2.times { create(:transaction, invoice: @customer_4_invoice_1, result: 'success') }

    2.times { create(:transaction, invoice: @customer_5_invoice_1, result: 'success') }

    create(:transaction, invoice: @customer_6_invoice_1, result: 'success')
    create(:transaction, invoice: @customer_6_invoice_2, result: 'failed')
  end

  describe "Class Methods" do
    describe ".top_five_customers_for" do
      it "returns an array of no more than five customer objects" do
        expect(Customer.top_five_customers_for(@merchant_1)).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
      end

      it "ordered descending by number of successful transactions" do
        5.times {@customer_6_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')}
        expect(Customer.top_five_customers_for(@merchant_1)).to eq([@customer_6, @customer_1, @customer_2, @customer_3, @customer_4])
      end
    end

    describe '.top_five_total_customers' do
      it 'returns top 5 customers for all merchants based on successful transaction count' do
        expect(Customer.top_five_total_customers).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
      end
    end
  end
end
