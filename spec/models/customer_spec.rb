require 'rails_helper'

RSpec.describe Customer, type: :model do
  before :each do
    load_test_data1
  end

  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:merchants).through(:invoices) }
    it { should have_many(:items).through(:invoices) }
  end
  
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe 'class methods' do
    describe '#top_5_customers' do
      it 'returns top 5 customers' do
        expect(Customer.top_5_customers).to eq([@customer_5, @customer_8, @customer_2, @customer_3, @customer_1])
        expect(Customer.top_5_customers.length).to eq(5)
        expect(Customer.top_5_customers).to_not include(@customer_7)
      end
    end
  end
end