require 'rails_helper'

RSpec.describe Customer do
  describe 'relations' do
    it { should have_many :invoices }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  let!(:customer_1) {Customer.create!(first_name: "Billy", last_name: "Joel")}
  let!(:invoice_1) {customer_1.invoices.create!(status: 1)}
  let!(:invoice_5) {customer_1.invoices.create!(status: 1)}
  let!(:invoice_9) {customer_1.invoices.create!(status: 1)}
  let!(:invoice_10) {customer_1.invoices.create!(status: 1)}
  let!(:transaction_1) {invoice_1.transactions.create!(result: 'success')}
  let!(:transaction_5) {invoice_5.transactions.create!(result: 'failed')}
  let!(:transaction_9) {invoice_9.transactions.create!(result: 'failed')}
  let!(:transaction_10) {invoice_10.transactions.create!(result: 'failed')}

  let!(:customer_2) {Customer.create!(first_name: "Britney", last_name: "Spears")}
  let!(:invoice_2) {customer_2.invoices.create!(status: 1)}
  let!(:invoice_6) {customer_2.invoices.create!(status: 1)}
  let!(:transaction_2) {invoice_2.transactions.create!(result: 'success')}
  let!(:transaction_6) {invoice_6.transactions.create!(result: 'success')}

  let!(:customer_3) {Customer.create!(first_name: "Prince", last_name: "Mononym")}
  let!(:invoice_3) {customer_3.invoices.create!(status: 1)}
  let!(:invoice_7) {customer_3.invoices.create!(status: 1)}
  let!(:invoice_11) {customer_3.invoices.create!(status: 1)}
  let!(:invoice_12) {customer_3.invoices.create!(status: 1)}
  let!(:transaction_3) {invoice_3.transactions.create!(result: 'failed')}
  let!(:transaction_7) {invoice_7.transactions.create!(result: 'success')}
  let!(:transaction_11) {invoice_11.transactions.create!(result: 'success')}
  let!(:transaction_12) {invoice_12.transactions.create!(result: 'success')}

  let!(:customer_4) {Customer.create!(first_name: "Garfunkle", last_name: "Oates")}
  let!(:invoice_4) {customer_4.invoices.create!(status: 1)      }
  let!(:invoice_8) {customer_4.invoices.create!(status: 1)}
  let!(:invoice_13) {customer_4.invoices.create!(status: 1)}
  let!(:invoice_14) {customer_4.invoices.create!(status: 1)}
  let!(:transaction_4) {invoice_4.transactions.create!(result: 'success')}
  let!(:transaction_8) {invoice_8.transactions.create!(result: 'success')}
  let!(:transaction_13) {invoice_13.transactions.create!(result: 'success')}
  let!(:transaction_14) {invoice_14.transactions.create!(result: 'success')}

  let!(:customer_5) {Customer.create!(first_name: "Rick", last_name: "James")}
  let!(:invoice_15) {customer_5.invoices.create!(status: 1)}
  let!(:invoice_16) {customer_5.invoices.create!(status: 1)}
  let!(:invoice_17) {customer_5.invoices.create!(status: 1)}
  let!(:invoice_18) {customer_5.invoices.create!(status: 1)}
  let!(:invoice_19) {customer_5.invoices.create!(status: 1)}
  let!(:transaction_15) {invoice_15.transactions.create!(result: 'success')}
  let!(:transaction_16) {invoice_16.transactions.create!(result: 'success')}
  let!(:transaction_17) {invoice_17.transactions.create!(result: 'success')}
  let!(:transaction_18) {invoice_18.transactions.create!(result: 'success')}
  let!(:transaction_19) {invoice_19.transactions.create!(result: 'success')}

  let!(:customer_6) {Customer.create!(first_name: "Dave", last_name: "Chappelle")}
  let!(:invoice_20) {customer_6.invoices.create!(status: 1)}
  let!(:transaction_20) {invoice_20.transactions.create!(result: 'failed')}

    describe 'class methods' do
      describe '.top_5' do
        it 'returns the top 5 customers ranked by successful transactions' do
          expect(Customer.top_5).to eq([customer_5, customer_4, customer_3, customer_2, customer_1])
        end
      end
    end
end
