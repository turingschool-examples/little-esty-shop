require 'rails_helper'

RSpec.describe Customer do
  describe 'relationships' do
    it {should have_many :invoices}
  end

  describe 'class methods' do
    describe '#top_customers' do
      before(:each) do
        customer1 = create(:customer)
        customer2 = create(:customer)
        customer3 = create(:customer)
        customer4 = create(:customer)
        customer5 = create(:customer)
        customer6 = create(:customer)
      # let(:customers) { create_list(:customer, 10) }
        Transaction.last(1).map { |t| t.update!(result: 1) }
    end
      it 'finds the top 5 customers' do
        expected = Customer.first(5)

        expect(Customer.top_customers.sort).to eq(expected.sort)
      end
    end
  end
end
