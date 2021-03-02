require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
  end

  describe "class methods" do
    describe '::display_enabled' do
      it 'displays merchants that have an enabled status' do
        merchant_1 = create(:merchant, status: 0)
        merchant_2 = create(:merchant, status: 0)
        merchant_3 = create(:merchant, status: 1)
        merchant_4 = create(:merchant, status: 1)
        merchant_5 = create(:merchant, status: 0)
        merchant_6 = create(:merchant, status: 0)
        merchant_7 = create(:merchant, status: 1)

        expect((Merchant.display_enabled).count).to eq(4)
      end
    end

    describe '::display_disabled' do
      it 'displays merchants that have a disabled status' do
        merchant_1 = create(:merchant, status: 0)
        merchant_2 = create(:merchant, status: 0)
        merchant_3 = create(:merchant, status: 1)
        merchant_4 = create(:merchant, status: 1)
        merchant_5 = create(:merchant, status: 0)
        merchant_6 = create(:merchant, status: 0)
        merchant_7 = create(:merchant, status: 1)

        expect((Merchant.display_disabled).count).to eq(3)
      end
    end
  end
end
