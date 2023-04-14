require 'rails_helper'

RSpec.describe Customer do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:items).through(:invoices) }
  end

  describe '#instance methods' do
    before(:each) do
      us_3_test_data
    end
    describe '#transaction_count' do
      it 'returns the count of all successful transactions for a merchant by customer' do
        expect(@cust_6.transaction_count(@merch_1)).to eq(6)
        expect(@cust_3.transaction_count(@merch_1)).to eq(4)
        expect(@cust_5.transaction_count(@merch_1)).to eq(2)
      end
    end
  end
end