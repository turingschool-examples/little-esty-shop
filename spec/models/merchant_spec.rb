require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Tillman Group')
    @merchant_2 = Merchant.create!(name: 'Kozy Group')
  end

  describe 'relationships' do
    it {should have_many :items}
  end

  describe 'class methods' do
    describe '::group_by_enabled' do
      it 'can group merchants by enabled status(true)' do
        @merchant_1.enable

        expect(Merchant.group_by_enabled).to eq([@merchant_1])
      end
    end

    describe '::group_by_disabled' do
      it 'can group merchants by disabled status(true)' do
        @merchant_1.enable

        expect(Merchant.group_by_disabled).to eq([@merchant_2])
      end
    end
  end

  describe 'instance methods' do
    describe '#enable' do
      it 'can update status to true(enabled)' do
        @merchant_1.enable
        expect(@merchant_1.status).to eq(true)
      end
    end

    describe '#disable' do
      it 'can update status to false(disabled)' do
        @merchant_1.disable
        expect(@merchant_1.status).to eq(false)
      end
    end
  end
end
