require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    before(:each) do
      @scream = Merchant.create!(name: 'Ice Scream', status: 0)
      @tattoo = Merchant.create!(name: 'Tattood Inc', status: 1)
      @plants = Merchant.create!(name: 'Growing Up', status:1)
    end

    describe '::disabled_merchants' do
      it 'finds rows where merchants are disabled' do
        expect(Merchant.disabled_merchants).to eq([@scream])
        expect(Merchant.disabled_merchants).to_not eq([@tattoo, @plants])
      end
    end

    describe '::enabled_merchants' do
      it 'finds rows where merchants are enabled' do
        expect(Merchant.enabled_merchants).to eq([@tattoo, @plants])
        expect(Merchant.enabled_merchants).to_not eq([@scream])
      end
    end
  end
end
