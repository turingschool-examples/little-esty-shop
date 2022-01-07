require 'rails_helper'

RSpec.describe Customer, type: :model do

  describe 'relationships' do
    it { should have_many(:invoices)}
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'instance methods' do
    describe 'successful_transactions' do
      it "returns all the sucessful transactions associated with that customer" do
        customer_1 = create(:customer_with_transactions, transaction_count: 3, transaction_result: 1)
        expect(customer_1.successful_transactions).to eq([])

        customer_2 = create(:customer_with_transactions, transaction_count: 3, transaction_result: 0)
        expect(customer_2.successful_transactions).to eq(customer_2.transactions)

        customer_3 = create(:customer_with_transactions, transaction_count: 3, transaction_result: 0)
        expected = customer_3.transactions
        invoice = create(:invoice, customer: customer_3)
        transaction = create(:transaction, invoice: invoice, result: 1)
        expect(customer_3.successful_transactions).to eq(expected)
      end

      it '#successful_transactions_count' do
        customer_1 = create(:customer, first_name: 'Bob', last_name: "Smith")
        customer_2 = create(:customer, first_name: 'John', last_name: "Charles")
        customer_3 = create(:customer, first_name: 'Abe', last_name: "McConnel")
        customer_4 = create(:customer, first_name: 'Zach', last_name: "Doe")
        customer_5 = create(:customer, first_name: 'Charlie', last_name: "Rey")

        merchant_1 = create(:merchant_with_invoices, invoice_count: 6, customer: customer_1, invoice_status: 2)
        merchant_2 = create(:merchant_with_invoices, invoice_count: 3, customer: customer_2, invoice_status: 2)
        merchant_3 = create(:merchant_with_invoices, invoice_count: 8, customer: customer_3, invoice_status: 2)
        merchant_4 = create(:merchant_with_invoices, invoice_count: 1, customer: customer_4, invoice_status: 2)
        merchant_5 = create(:merchant_with_invoices, invoice_count: 4, customer: customer_5, invoice_status: 2)
        expect(customer_1.successful_transactions_count).to eq 6
      end
    end

    describe '#full_name' do
      it 'returns the full name of the customer' do
        customer_1 = create(:customer, first_name: 'Bob', last_name: "Smith")

        expect(customer_1.full_name).to eq "Bob Smith"
      end
    end
  end
end
