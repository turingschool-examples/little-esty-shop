require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices).dependent(:destroy) }
  end

  before(:each) do
    @customer = create(:customer)
  end

  describe '#instance methods' do
    describe '#full_name' do
      it 'returns customers full name' do
        expect(@customer.full_name).to eq("John Doe")
      end
    end
  end
end
