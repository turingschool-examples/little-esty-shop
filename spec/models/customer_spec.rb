require 'rails_helper'

RSpec.describe Customer do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
  end
  describe 'instance methods' do
    xit 'top_customers returns the 5 customers with most transactions descending' do
      top_cust = Customer.top_customers
      expect(top_cust[0].transaction_total).to be >= (top_cust[1].transaction_total)
      expect(top_cust.size).to eq(5)
    end
  end
end