require 'rails_helper'

RSpec.describe Customer do
  before(:each) do
  end

  describe 'relationships' do
    it {should have_many :invoices}
  end

  describe 'class methods' do
    describe 'top_customers' do
      it 'returns the top 5 customer by number of successful transactions' do
        top_customers = Customer.top_five
 
        expect(top_customers[0].name).to eq("Alessandra Ward")
        expect(top_customers[1].name).to eq("Ben Turner")
        expect(top_customers[2].name).to eq("Estel Hermiston")
        expect(top_customers[3].name).to eq("Helmer Baumbach")
        expect(top_customers[4].name).to eq("Isaac Zulauf")
      end
    end
  end

  describe 'instance methods' do
    describe '.full_name' do
      it 'returns full_name of customer' do
        customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka') 

        expect(customer.full_name).to eq ('Joey Ondricka')
      end
    end
  end
end
