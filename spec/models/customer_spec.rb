require 'rails_helper'

RSpec.describe Customer do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
  end
  describe 'instance methods' do
    it 'top_customers returns the 5 customers with most transactions descending' do
      cust1 = Customer.create!(first_name: 'Harry', last_name: 'Potter')
      inv1 = cust1.invoices.create!(status: 1)
      transaction1 = inv1.transactions.create!(credit_card_number: 3395123433951234, result: 1)
      inv2 = cust1.invoices.create!(status: 1)
      transaction2 = inv2.transactions.create!(credit_card_number: 3395123433951234, result: 1)
      inv3 = cust1.invoices.create!(status: 1)
      transaction3 = inv3.transactions.create!(credit_card_number: 3395123433951234, result: 1)
      inv4 = cust1.invoices.create!(status: 1)
      transaction4 = inv4.transactions.create!(credit_card_number: 3395123433951234, result: 1)
      inv5 = cust1.invoices.create!(status: 1)
      transaction5 = inv5.transactions.create!(credit_card_number: 3395123433951234, result: 0)
      
      cust2 = Customer.create!(first_name: 'Hermione', last_name: 'Granger')
      inv1 = cust2.invoices.create!(status: 1)
      transaction1 = inv1.transactions.create!(credit_card_number: 3395123433951234, result: 1)
      inv2 = cust2.invoices.create!(status: 1)
      transaction2 = inv2.transactions.create!(credit_card_number: 3395123433951234, result: 1)
      inv3 = cust2.invoices.create!(status: 1)
      transaction3 = inv3.transactions.create!(credit_card_number: 3395123433951234, result: 1)
      
      cust3 = Customer.create!(first_name: 'Ron', last_name: 'Weasley')
      inv1 = cust3.invoices.create!(status: 1)
      transaction1 = inv1.transactions.create!(credit_card_number: 3395123433951234, result: 1)
      inv2 = cust3.invoices.create!(status: 1)
      transaction2 = inv3.transactions.create!(credit_card_number: 3395123433951234, result: 1)
      inv3 = cust3.invoices.create!(status: 1)
      transaction3 = inv3.transactions.create!(credit_card_number: 3395123433951234, result: 0)
      
      
      cust4 = Customer.create!(first_name: 'Luna', last_name: 'Lovegood')
      inv1 = cust4.invoices.create!(status: 1)
      transaction1 = inv1.transactions.create!(credit_card_number: 3395123433951234, result: 1)
      inv2 = cust4.invoices.create!(status: 1)
      transaction2 = inv3.transactions.create!(credit_card_number: 3395123433951234, result: 1)
      inv3 = cust4.invoices.create!(status: 1)
      transaction3 = inv3.transactions.create!(credit_card_number: 3395123433951234, result: 1)
      inv4 = cust4.invoices.create!(status: 1)
      transaction4 = inv4.transactions.create!(credit_card_number: 3395123433951234, result: 1)
      
      cust5 = Customer.create!(first_name: 'Albus', last_name: 'Dumbledor')
      inv1 = cust5.invoices.create!(status: 1)
      transaction1 = inv1.transactions.create!(credit_card_number: 3395123433951234, result: 1)
      inv2 = cust5.invoices.create!(status: 0)
      transaction2 = inv3.transactions.create!(credit_card_number: 3395123433951234, result: 0)
      
      cust6 = Customer.create!(first_name: 'Sirius', last_name: 'Black')
      inv1 = cust6.invoices.create!(status: 1)
      transaction1 = inv1.transactions.create!(credit_card_number: 3395123433951234, result: 1)
      inv2 = cust6.invoices.create!(status: 1)
      transaction2 = inv3.transactions.create!(credit_card_number: 3395123433951234, result: 0)
      
      top_cust = Customer.top_customers

      expect(top_cust[0].first_name).to eq('Harry')
      expect(top_cust[1].first_name).to eq('Hermione')
      expect(top_cust[4].first_name).to eq('Albus')
      expect(top_cust.include?(cust6)).to be false
      expect(top_cust.size).to eq(5)
    end
  end
end