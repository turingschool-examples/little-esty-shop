require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Tillman Group')
  end

  describe 'relationships' do
    it {should have_many :items}
  end

  describe 'instance methods' do
    describe '#enable' do
      it 'can update status to true(enabled)' do
        expect(@merchant_1.enable).to eq(true)
      end
    end

    describe '#disable' do
      it 'can update status to false(disabled)' do
        expect(@merchant_1.disable).to eq(false)
      end 
    end
  end
end
