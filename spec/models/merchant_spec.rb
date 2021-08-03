require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
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

    describe '.top_5_merchants_revenue' do
      it 'can get the top 5 merchants by their revenue based off of successful transactions' do
        expect(Merchant.top_5_merchants_revenue).to eq([@merchant2, @merchant1, @merchant3])  
      end
    end
  end

  describe 'instance methods' do
    describe '#best_day' do
      xit 'can get the best day for revenue for the top 5 merchants by revenue' do
        expect(@merchant1.best_day)
      end
    end
  end
end
