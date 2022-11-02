require 'rails_helper'

RSpec.describe Customer do 
  describe 'relationships' do 
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:items).through(:invoices) }
  end

  before(:each) do 
    @customer1 = Customer.create!(first_name: 'Dandy', last_name: 'Dan')
  end

  describe 'instance methods' do 
    describe '#name' do 
      it 'returns full name of customer' do 
        expect(@customer1.name).to eq('Dandy Dan')
      end
    end
  end
end