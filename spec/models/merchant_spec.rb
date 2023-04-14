require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:items).dependent(:destroy) }
    it { should have_many(:invoices).through(:items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe '#instance methods' do
    describe '#favorite_customers' do
      it 'returns an array of top five customers with most purchases' do
        expect(@merch_1.favorite_customer).to eq(2)
      end
    end
  end
end