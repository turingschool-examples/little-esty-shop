require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it {should have_many :invoices}
  end

  describe "instance methods" do
    describe "#name" do
      it "returns the customers full name" do
        customer = Customer.create!(first_name: "Bob", last_name: "Jones")
        expect(customer.name).to eq("Bob Jones")
      end
    end

    describe '#successful_transactions_count' do
      it 'finds count of successful transactions' do
        customer = Customer.create!(first_name: "Bob", last_name: "Jones")
        invoice_1 = create(:invoice, customer_id: customer.id)
        transaction = create(:transaction, invoice_id: invoice_1.id, result: 0)
        expect(customer.successful_transactions_count).to eq(1)
      end
    end
  end
end
