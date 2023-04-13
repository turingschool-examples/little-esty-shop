require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe "class methods" do
    describe ".top_5_by_transactions" do
      it 'returns the 5 customers with the largest number of successful transactions' do
        @customer_1 = create(:customer) # 5 successful transactions
        @customer_2 = create(:customer) # 4 successful transactions
        @customer_3 = create(:customer) # 3 successful transactions
        @customer_4 = create(:customer) # 2 successful transactions
        @customer_5 = create(:customer) # 1 successful transaction

        5.times do
          invoice = create(:invoice, customer: @customer_1)
          create(:transaction, result: true, invoice: invoice)
        end

        4.times do
          invoice = create(:invoice, customer: @customer_2)
          create(:transaction, result: true, invoice: invoice)
        end

        3.times do
          invoice = create(:invoice, customer: @customer_3)
          create(:transaction, result: true, invoice: invoice)
        end

        2.times do
          invoice = create(:invoice, customer: @customer_4)
          create(:transaction, result: true, invoice: invoice)
        end

        invoice = create(:invoice, customer: @customer_5)
        create(:transaction, result: true, invoice: invoice)
        create(:transaction, result: false, invoice: invoice)

        @customer_6 = create(:customer) # no successful transactions
        2.times do
          invoice = create(:invoice, customer: @customer_6)
          create(:transaction, result: false, invoice: invoice)
        end

        expect(Customer.top_5_by_transactions).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
      end
    end
  end

  describe "instance methods" do
    describe "#get_name" do
      it 'displays the full name of the customer' do
        customer = Customer.create!(first_name: "Jane", last_name: "Doe")
        expect(customer.get_name).to eq("Jane Doe")
      end
    end

    describe "#count_successful_transactions" do
      it 'returns a count of a customers successful transactions' do
        customer_1 = create(:customer)
        customer_2 = create(:customer)

        5.times do
          invoice = create(:invoice, customer: customer_1)
          create(:transaction, result: true, invoice: invoice)
        end

        2.times do
          invoice = create(:invoice, customer: customer_1)
          create(:transaction, result: false, invoice: invoice)
        end

        expect(customer_1.count_successful_transactions).to eq(5)
        expect(customer_2.count_successful_transactions).to eq(0)
      end
    end
  end
end
