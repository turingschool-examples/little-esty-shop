require 'rails_helper'

RSpec.describe Customer do
  describe 'Relationships' do
    it {should have_many :invoices}
    it {should have_many :transactions}
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
  end
<<<<<<< HEAD
=======


  describe '#transactions_with_merchant()' do
    it 'returns the number of successful transactions with a given merchant' do
      cust1 = Customer.find(1)
      # require 'pry'; binding.pry
      expect(cust1.transactions_with_merchant(2)).to eq(5)
    end
    
  it 'Selects the top 5 customers by successful transaction' do
    expect(Customer.top_5_by_transactions).to eq([Customer.find(12), Customer.find(13), Customer.find(10), Customer.find(7), Customer.find(4)])
  end

  it 'Counts the number of successful transactions' do
    expect(Customer.find(12).transactions_count).to eq(9)

  end
>>>>>>> 57fd61a4eb59e1f16ff758251b924710b5d65fd0
end