require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end


  describe '.class methods' do
    describe 'top_five_customers_by_merchant' do
      xit 'can find the top five customers with the most transactions for a specific merchant' do
        expected_hash = {}

        expect(Customer.top_five_customers_admin).to eq(expected_hash)
      end
    end 
    
    describe 'top_five_customers_admin' do
      it 'Should return the top five customers in a hash with the customer name and amount of successful transactions' do
        expected_hash = {
          %w[Daugherty Parker] => 8,
          %w[Ondricka Joey] => 7,
          %w[Braun Leanne] => 7,
          %w[Toy Mariah] => 3,
          %w[Osinski Cecelia] => 1
        }
        expect(Customer.top_five_customers_admin).to eq expected_hash
      end 
    end
  end
end
