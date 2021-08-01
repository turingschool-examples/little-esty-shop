require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices).through(:items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
   describe '.enabled_merchants' do
      it 'can get all the merchants that are enabled' do
        expect(Merchant.enabled_merchants).to eq([@merchant5, @merchant6])  
      end
    end

    describe '.disabled_merchants' do
      it 'can get all the merchants that are disabled' do
        expect(Merchant.disabled_merchants).to eq([@merchant1, @merchant2, @merchant3, @merchant4, @merchant7])  
      end
    end
  end

  # describe 'instance methods' do
  #   describe '#' do
  #   end
  # end
end
