require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "Relationships" do
    it { should have_many(:invoices) }
  end
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Dave")
    @merchant_2 = Merchant.create!(name: "Kevin")

    @merchant_1_item_1 = @merchant_1.items.create!(name: "Pencil", description: "Writing implement", unit_price: 1)
    @merchant_1_item_not_ordered = @merchant_1.items.create!(name: "Unordered Item", description: "...", unit_price: 2)
    @merchant_1_item_3 = @merchant_1.items.create!(name: "Newest Item", description: "...", unit_price: 1)
    @merchant_2_item_1 = @merchant_2.items.create!(name: "Mechanical Pencil", description: "Writing implement", unit_price: 2)

    @customer_1 = Customer.create!(first_name: "Bob", last_name: "Jones")
    @customer_2 = Customer.create!(first_name: "Milly", last_name: "Smith")
    @customer_3 = Customer.create!(first_name: "David", last_name: "Hill")
    @customer_4 = Customer.create!(first_name: "Sarah", last_name: "Miller")
    @customer_5 = Customer.create!(first_name: "Patrick", last_name: "Baker")
    @customer_6 = Customer.create!(first_name: "Rebecca", last_name: "Simpson")

    #invoice status: 0 cancelled, 1 completed, 2 in progress
    @customer_1_invoice_1 = @customer_1.invoices.create!(status: 1)
    @customer_1_invoice_2 = @customer_1.invoices.create!(status: 1)

    @customer_2_invoice_1 = @customer_2.invoices.create!(status: 1)
    @customer_3_invoice_1 = @customer_3.invoices.create!(status: 1)
    @customer_4_invoice_1 = @customer_4.invoices.create!(status: 1)
    @customer_5_invoice_1 = @customer_5.invoices.create!(status: 1)

    @customer_6_invoice_1 = @customer_6.invoices.create!(status: 1)
    @customer_6_invoice_2 = @customer_6.invoices.create!(status: 0)

    @invoice_item_1 = InvoiceItem.create!(invoice: @customer_1_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 2)
    InvoiceItem.create!(invoice: @customer_1_invoice_2, item: @merchant_2_item_1, quantity: 1, unit_price: 4, status: 0)

    InvoiceItem.create!(invoice: @customer_2_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 2)
    InvoiceItem.create!(invoice: @customer_3_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 2)
    InvoiceItem.create!(invoice: @customer_4_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 2)
    InvoiceItem.create!(invoice: @customer_5_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 2)

    @invoice_item_2 = InvoiceItem.create!(invoice: @customer_6_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 0)
    @invoice_item_3 = InvoiceItem.create!(invoice: @customer_6_invoice_2, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 1)

    @customer_1_transaction_1 = @customer_1_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
    @customer_1_transaction_2 = @customer_1_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
    @customer_1_transaction_3 = @customer_1_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
    @customer_1_transaction_4 = @customer_1_invoice_2.transactions.create!(credit_card_number: 1234123412341234, result: 'success')

    @customer_2_transaction_1 = @customer_2_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
    @customer_2_transaction_2 = @customer_2_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')

    @customer_3_transaction_1 = @customer_3_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
    @customer_3_transaction_2 = @customer_3_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')

    @customer_4_transaction_1 = @customer_4_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
    @customer_4_transaction_2 = @customer_4_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')

    @customer_5_transaction_1 = @customer_5_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
    @customer_5_transaction_2 = @customer_5_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')

    @customer_6_transaction_1 = @customer_6_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
    @customer_6_transaction_2 = @customer_6_invoice_2.transactions.create!(credit_card_number: 1234123412341234, result: 'failed')
  end

  describe "class methods" do
    describe ".top_five_customers_for" do
      it "returns an array of no more than five customer objects" do
        expect(Customer.top_five_customers_for(@merchant_1)).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
      end

      it "ordered descending by number of successful transactions" do
        5.times {@customer_6_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')}
        expect(Customer.top_five_customers_for(@merchant_1)).to eq([@customer_6, @customer_1, @customer_2, @customer_3, @customer_4])
      end
    end

    describe "instance methods" do
      describe '#top_five_total_customers' do
        it 'returns top 5 customers for all merchants based on successful transaction count' do
          expect(Customer.top_five_total_customers).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
        end
      end
    end
  end
end
