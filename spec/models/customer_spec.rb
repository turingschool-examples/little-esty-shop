require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
  end
  
  describe '::Class Methods' do
    before(:each) do
      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)
      @customer_5 = create(:customer)
      @customer_6 = create(:customer)
  
      @invoice_1 = create(:invoice, customer_id: @customer_1.id)
      @invoice_2 = create(:invoice, customer_id: @customer_2.id)
      @invoice_3 = create(:invoice, customer_id: @customer_3.id)
      @invoice_4 = create(:invoice, customer_id: @customer_4.id)
      @invoice_5 = create(:invoice, customer_id: @customer_5.id)
    end

    describe '::top_five_customers' do
      it 'returns the top five customers, ordered by successful transactions' do
        create(:transaction, invoice_id: @invoice_1.id, result: 0)
        2.times { create(:transaction, invoice_id: @invoice_2.id, result: 0) }
        3.times { create(:transaction, invoice_id: @invoice_3.id, result: 0) }
        4.times { create(:transaction, invoice_id: @invoice_4.id, result: 0) }
        5.times { create(:transaction, invoice_id: @invoice_5.id, result: 0) }

        expect(Customer.top_five_customers).to eq([@customer_5, @customer_4, @customer_3, @customer_2, @customer_1])
      end
    end
  end
end
