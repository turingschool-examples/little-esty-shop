require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices, through: :items }
    it { should have_many :customers, through: :invoices }
    it { should have_many :transactions, through: :invoices }
  end

  describe '#instance methods' do
    describe '.top_5_customers' do
      xit "returns the top 5 customers for a merchant" do
        expect()
      end
    end
  end
end