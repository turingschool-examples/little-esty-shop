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

        customer_3 = create(:customer)
        transaction_1 = create(:transaction_with_customer, customer: customer_3, result: 0)
        transaction_2 = create(:transaction_with_customer, customer: customer_3, result: 1)
        transaction_3 = create(:transaction_with_customer, customer: customer_3, result: 0)
        transaction_4 = create(:transaction_with_customer, customer: customer_3, result: 0)

        expect(customer_3.successful_transactions).to eq([transaction_1, transaction_3, transaction_4])
      end

      it '#successful_transactions_count' do
        customer_1 = create(:customer_with_transactions, first_name: 'Bob', last_name: "Smith", transaction_result: 0, transaction_count: 6)
        customer_2 = create(:customer_with_transactions, first_name: 'Troy', last_name: "Smith", transaction_result: 0, transaction_count: 8)
        customer_3 = create(:customer_with_transactions, first_name: 'Bill', last_name: "Smith", transaction_result: 0, transaction_count: 1)

        expect(customer_1.successful_transactions_count).to eq(6)
        expect(customer_2.successful_transactions_count).to eq(8)
        expect(customer_3.successful_transactions_count).to eq(1)
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
