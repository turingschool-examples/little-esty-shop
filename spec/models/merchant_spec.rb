require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:items).dependent(:destroy) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe '#instance methods' do
    before(:each) do
      us_3_test_data
    end
    describe '#favorite_customers' do
      it 'returns an array of top five customers with most purchases' do
        expect(@merch_1.favorite_customers).to eq([@cust_6, @cust_2, @cust_3, @cust_4, @cust_5])
      end
    end
  end
end