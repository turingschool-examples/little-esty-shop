require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through (:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe '.class methods' do
    describe 'top_five_customers' do
      xit 'can find the top five customers with the most transactions for a specific merchant' do
        expected_hash = {}

        expect(Customer.top_five_customers).to eq(expected_hash)
      end
    end
  end
end
