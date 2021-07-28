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
        
        invoice1 = create(:invoice, customer_id: customer1.id)
        invoice2 = create(:invoice, customer_id: customer2.id)
        invoice3 = create(:invoice, customer_id: customer3.id)
        invoice4 = create(:invoice, customer_id: customer4.id)
        invoice5 = create(:invoice, customer_id: customer5.id)
        invoice6 = create(:invoice, customer_id: customer6.id)

        transaction1 = create(:transaction, invoice_id: invoice1.id)
        transaction2 = create(:transaction, invoice_id: invoice1.id)
        transaction3 = create(:transaction, invoice_id: invoice2.id)
        transaction4 = create(:transaction, invoice_id: invoice3.id)
        transaction5 = create(:transaction, invoice_id: invoice4.id)
        transaction6 = create(:transaction, invoice_id: invoice5.id)
        transaction7 = create(:transaction, invoice_id: invoice6.id)

        Transaction.last(1).map { |t| t.update!(result: 1) }
    end
      it 'finds the top 5 customers' do
        expected = Customer.first(5)
        # require 'pry'; binding.pry
        expect(Customer.top_customers.sort).to eq(expected.sort)
      end
    end
  end
end
