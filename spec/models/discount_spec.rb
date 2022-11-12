require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
  end
  describe 'by_id' do
    it 'finds discounts by merchant id' do
      merchant1 = Merchant.create!(name: 'Marvel')
      discount1 = Discount.create!(merchant_id: merchant1.id, quantity_threshhold: 5, percentage: 0.2)
      discount2 = Discount.create!(merchant_id: merchant1.id, quantity_threshhold: 10, percentage: 0.4)
      expect(Discount.by_id(merchant1)).to eq([discount1, discount2])
    end
  end
end
