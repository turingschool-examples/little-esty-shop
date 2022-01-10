require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many :invoices }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe "instance methods" do
    let!(:customer_1) {FactoryBot.create(:customer)}
    let!(:invoice_1) {FactoryBot.create(:invoice, customer: customer_1)}
    let!(:transaction_1) {FactoryBot.create(:transaction, invoice: invoice_1)}
    let!(:transaction_2) {FactoryBot.create(:transaction, invoice: invoice_1)}
    let!(:transaction_3) {FactoryBot.create(:transaction, invoice: invoice_1)}
    let!(:transaction_4) {FactoryBot.create(:transaction, invoice: invoice_1)}
    describe '#transaction_count' do
      it 'returns number of transaction for customer' do
        expect(customer_1.transaction_count).to eq(4)
      end
    end
  end

  describe "class methods" do
    let!(:customer_1) {FactoryBot.create(:customer)}
    let!(:customer_2) {FactoryBot.create(:customer)}
    let!(:customer_3) {FactoryBot.create(:customer)}
    let!(:customer_4) {FactoryBot.create(:customer)}
    let!(:customer_5) {FactoryBot.create(:customer)}
    let!(:customer_6) {FactoryBot.create(:customer)}

    let!(:invoice_1) {FactoryBot.create(:invoice, customer: customer_1, status: "in progress")}
    let!(:invoice_2) {FactoryBot.create(:invoice, customer: customer_2, status: "in progress")}
    let!(:invoice_3) {FactoryBot.create(:invoice, customer: customer_3, status: "in progress")}
    let!(:invoice_4) {FactoryBot.create(:invoice, customer: customer_4, status: "in progress")}
    let!(:invoice_5) {FactoryBot.create(:invoice, customer: customer_5, status: "in progress")}

    let!(:transaction_1) {FactoryBot.create(:transaction, invoice: invoice_1, result: "success")}
    let!(:transaction_2) {FactoryBot.create(:transaction, invoice: invoice_1, result: "success")}
    let!(:transaction_3) {FactoryBot.create(:transaction, invoice: invoice_1, result: "success")}

    let!(:transaction_4) {FactoryBot.create(:transaction, invoice: invoice_2, result: "success")}
    let!(:transaction_5) {FactoryBot.create(:transaction, invoice: invoice_2, result: "success")}
    let!(:transaction_6) {FactoryBot.create(:transaction, invoice: invoice_2, result: "success")}
    let!(:transaction_7) {FactoryBot.create(:transaction, invoice: invoice_2, result: "success")}
    let!(:transaction_8) {FactoryBot.create(:transaction, invoice: invoice_2, result: "success")}

    let!(:transaction_9) {FactoryBot.create(:transaction, invoice: invoice_3, result: "success")}

    let!(:transaction_10) {FactoryBot.create(:transaction, invoice: invoice_4, result: "success")}
    let!(:transaction_11) {FactoryBot.create(:transaction, invoice: invoice_4, result: "success")}
    let!(:transaction_12) {FactoryBot.create(:transaction, invoice: invoice_4, result: "success")}
    let!(:transaction_13) {FactoryBot.create(:transaction, invoice: invoice_4, result: "success")}

    let!(:transaction_14) {FactoryBot.create(:transaction, invoice: invoice_5, result: "success")}
    let!(:transaction_15) {FactoryBot.create(:transaction, invoice: invoice_5, result: "success")}
    let!(:transaction_16) {FactoryBot.create(:transaction, invoice: invoice_5, result: "failed")}

    describe '#top_5' do
      it 'returns 5 customer names with highest count of successful transactions' do
        expect(Customer.top_5).to eq([customer_2, customer_4, customer_1, customer_5, customer_3])
      end
    end
  end

end
