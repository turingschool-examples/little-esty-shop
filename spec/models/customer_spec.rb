require 'rails_helper'

RSpec.describe Customer do
  describe 'Relationships' do
    it {should have_many :invoices}
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
  end

  describe '#transactions_with_merchant()' do
    it 'returns the number of successful transactions with a given merchant' do
      cust1 = Customer.find(1)

      expect(cust1.transactions_with_merchant(2)).to eq(7)
    end
  end
end